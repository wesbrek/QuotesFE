# Stage 1
FROM node:8 as react-build
WORKDIR /app
COPY . ./
COPY ./pry-componentes/package.json
RUN yarn
RUN yarn build

# Stage 2 - the production environment
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=react-build /app/build /usr/share/nginx/html
EXPOSE 85
CMD ["nginx", "-g", "daemon off;"]