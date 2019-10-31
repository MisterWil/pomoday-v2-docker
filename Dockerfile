# Build a pomoday-v2 dist from source
FROM node:alpine as builder

# pomoday-v2 dependencies require python and make/gcc
RUN apk update && \
    apk add --no-cache git python3-dev make g++
    
RUN git clone -b master --depth=1 https://github.com/huytd/pomoday-v2.git && \
    cd pomoday-v2 && \
    npm install && \
    npm run dist

# Build the nginx container
FROM nginx:alpine

LABEL maintainer="MisterWil <wilrader@gmail.com>"

# Delete any defaults from the nginx web root
RUN rm -rf /usr/share/nginx/html/*

# Copy the build pomoday-v2 dist into the web root
COPY --from=builder /pomoday-v2/dist /usr/share/nginx/html

EXPOSE 80
