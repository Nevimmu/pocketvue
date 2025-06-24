# Development Stage
FROM node:lts as dev
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend .
ENV NODE_ENV=development
EXPOSE 8080
CMD ["npm", "run", "dev"]

# Stage 1: Build dependencies (optimized for caching)
FROM node:lts as builder
WORKDIR /app
COPY frontend/package*.json ./
RUN npm ci
COPY frontend .
RUN npm run build
RUN npm prune --omit=dev

# Stage 2: Production (Nginx)
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]