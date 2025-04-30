# Step 1: Build the React app
FROM node:18-alpine AS build

WORKDIR /app

# Copy package.json and install dependencies
# COPY package.json package-lock.json ./
RUN npm install

# Copy all project files and build
COPY . .
RUN npm run build

# Step 2: Serve the build using a lightweight web server (e.g., nginx)
FROM nginx:alpine

# Remove default nginx static files and copy build output
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/dist /usr/share/nginx/html  # For Vite
# OR use this line if using Create React App:
# COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
