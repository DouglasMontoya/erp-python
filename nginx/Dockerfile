FROM alpine
ARG HOST
ARG PORT
ARG SERVER_NAME
RUN --mount=type=cache,target=/var/cache/apk,sharing=locked \
  --mount=type=cache,target=/var/lib/apk,sharing=locked \
  apk add --update --no-cache brotli nginx nginx-mod-http-brotli envsubst

# Minimal config
COPY ./nginx/nginx.conf.template /etc/nginx/conf.d/autoges.conf.template
RUN envsubst '${HOST} ${PORT} ${SERVER_NAME}' < \
  /etc/nginx/conf.d/autoges.conf.template > /etc/nginx/http.d/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
