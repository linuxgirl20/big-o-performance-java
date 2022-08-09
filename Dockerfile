FROM node:16.13.2 as builder
# set working directory
WORKDIR /app
# install and cache app dependencies
COPY . ./

RUN npm install 
#RUN npm install -g live-server
RUN npm run build

# start app
FROM nginx:alpine
# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*

COPY --from=builder /app/build .
COPY --from=builder /app/default.conf /etc/nginx/conf.d/default.conf
ENTRYPOINT ["nginx", "-g", "daemon off;"]
