# stage 0 src
FROM alpine:latest as src

WORKDIR /tmp

RUN apk --no-cache add git
RUN git clone https://github.com/temorfeouz/gocho.git

# stage 1 ui
FROM node:carbon AS ui

COPY --from=src /tmp/gocho/ui ./build

WORKDIR /build

RUN yarn build

# stage 2 build
FROM golang:1.21-alpine AS build

WORKDIR /go/src/github.com/temorfeouz/gocho

RUN apk --no-cache add git make

COPY --from=src /tmp/gocho/. /go/src/github.com/temorfeouz/gocho/
COPY --from=ui /build/ /go/src/github.com/temorfeouz/gocho/ui

RUN mkdir /go/src/github.com/jteeuwen && cd /go/src/github.com/jteeuwen && git clone https://github.com/jteeuwen/go-bindata.git && cd go-bindata \
    && go mod init github.com/jteeuwen/go-bindata && go mod tidy && cd go-bindata && go build . && mv go-bindata /usr/bin/go-bindata

RUN make generate && go mod vendor && CGO_ENABLED=0 go build -ldflags "-s" -o /usr/bin/gocho cmd/gocho/gocho.go

# stage 3 image
FROM scratch

COPY --from=build /usr/bin/gocho /usr/bin/gocho

ENTRYPOINT [ "/usr/bin/gocho"]