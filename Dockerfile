# nginx版本
# FROM nginx:1.15.0
# COPY dist /usr/share/nginx/html/

# node版本
FROM node:9-slim
RUN apt-get update     && apt-get install -y nginx
WORKDIR /app
COPY . /app/
EXPOSE 80
RUN  npm install      && npm run build      && cp -r dist/* /var/www/html      && rm -rf /app
CMD ["nginx","-g","daemon off;"]