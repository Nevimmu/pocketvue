# Stage 1: Build Vue.js application
FROM node:18-alpine as vue-builder
WORKDIR /web
COPY frontend/package*.json ./
RUN npm install
COPY frontend .
RUN npm run build

# Stage 2: Prepare PocketBase
FROM alpine:latest as pb-prepare
ARG PB_VERSION=0.28.2
RUN apk add --no-cache \
    unzip \
    wget \
    ca-certificates
# Download PocketBase
RUN wget -O /tmp/pb.zip https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip && \
    unzip /tmp/pb.zip -d /tmp/pb/ && \
    mv /tmp/pb/pocketbase /pocketbase

# Stage 3: Final image
FROM node:18-alpine
# Install runtime dependencies
RUN apk add --no-cache bash ca-certificates
# Copy PocketBase binary
COPY --from=pb-prepare /pocketbase/ /pocketbase/
# Create directories
RUN mkdir -p /pocketbase/pb_migrations /pocketbase/pb_public
# Copy backend files
COPY backend/pb_migrations /pocketbase/pb_migrations
COPY backend/init-pb.sh /pocketbase/init-pb.sh
RUN chmod +x /pocketbase/init-pb.sh
# Copy built Vue app
COPY --from=vue-builder /web/dist /pocketbase/pb_public
# For development - copy source code (overridden by volume in dev)
COPY frontend /web
WORKDIR /web
# Install dependencies
RUN npm install
# Entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8090 5173

ENTRYPOINT ["/entrypoint.sh"]