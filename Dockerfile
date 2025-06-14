# Stage 1: Build the React app
FROM node:18-alpine AS builder

WORKDIR /app

# Only copy package.json since package-lock.json doesn't exist
COPY package.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project
COPY . .

# Build the app
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:latest AS deployer

# Copy the build output to Nginx HTML folder
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
