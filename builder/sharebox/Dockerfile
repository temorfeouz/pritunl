# stage 0 src
FROM alpine:latest as src

WORKDIR /tmp

RUN apk --no-cache add git
RUN git clone https://github.com/bleenco/sharebox.git

# stage 1 ui
FROM node:14.17.0-alpine AS ui

COPY --from=src /tmp/sharebox/ui ./app/ui

WORKDIR /app/ui

RUN apk add python3 make g++ --no-cache
RUN npm install --save-dev  --unsafe-perm node-sass
RUN npm install && npm run build

# stage 2 build
FROM golang:1.21-alpine AS build

WORKDIR /go/src/github.com/bleenco/sharebox

RUN apk --no-cache add git

COPY --from=src /tmp/sharebox/. /go/src/github.com/bleenco/sharebox/
COPY --from=ui /app/ui/dist /go/src/github.com/bleenco/sharebox/dist

RUN mkdir /go/src/github.com/jteeuwen && cd /go/src/github.com/jteeuwen && git clone https://github.com/jteeuwen/go-bindata.git && cd go-bindata \
    && go mod init github.com/jteeuwen/go-bindata && go mod tidy && cd go-bindata && go build . && mv go-bindata /usr/bin/go-bindata

RUN go-bindata ./dist/... 
RUN mkdir -p build && go mod init && go mod tidy && go mod vendor && CGO_ENABLED=0 go build -o build/sharebox *.go

# stage 3 image
FROM scratch

COPY --from=build /go/src/github.com/bleenco/sharebox/build/sharebox /usr/bin/sharebox

ENTRYPOINT [ "/usr/bin/sharebox" ]