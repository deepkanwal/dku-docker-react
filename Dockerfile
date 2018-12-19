# Step 1: Create build folder.
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Step 2: Serve build folder.
FROM nginx

# Elastic Beanstalk will look at this EXPOSE for port mapping of incoming traffic. 
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
