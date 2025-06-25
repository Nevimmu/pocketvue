# Stage 1: Build Vue.js application
FROM node:18-alpine as vue-builder
WORKDIR /web
COPY frontend/package*.json ./
RUN npm install
COPY frontend .
RUN npm run build

# Stage 2: Prepare PocketBase
# TODO: compile main.go and use it for the backend 
FROM golang:1.24-alpine as pb-prepare
WORKDIR /pocketbase
COPY backend/ ./
# RUN go mod init backend && go mod tidy
RUN go mod download && go build

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