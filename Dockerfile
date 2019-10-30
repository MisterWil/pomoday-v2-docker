FROM node:alpine as builder

RUN apk update && \
    apk add --no-cache git python3-dev make g++

RUN git clone -b master --depth=1 https://github.com/huytd/pomoday-v2.git && \
    cd pomoday-v2 && \
    npm install && \
    npm run dist

FROM nginx:alpine

RUN rm -rf /usr/share/ngins/html/*
    
COPY --from=builder /pomoday-v2/dist /usr/share/nginx/html

EXPOSE 80
