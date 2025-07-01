# Use nginx to serve the app
FROM nginx:alpine

# Remove default nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy build files
COPY build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx

CMD ["nginx", "-g", "daemon off;"]
