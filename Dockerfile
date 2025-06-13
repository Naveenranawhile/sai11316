# Stage 1: Build the app
FROM node:18-alpine AS builder

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy source code
COPY . .

# Build the app
RUN npm run build

# Stage 2: Serve with nginx
FROM nginx:latest AS deployer

# Copy build files from builder
COPY --from=builder /app/build /usr/share/nginx/html

# Optional: expose port and set default command
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
