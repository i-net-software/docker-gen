FROM golang as gobuild
RUN go get github.com/i-net-software/docker-gen
RUN mv $GOPATH/src/github.com/i-net-software/docker-gen / && \
    cd /docker-gen && \
    make get-deps && \
    make all && \
    cp dist/docker-gen /go/bin/docker-gen

FROM alpine:latest
LABEL maintainer="Jason Wilder <mail@jasonwilder.com>"

RUN apk -U add openssl libc6-compat

ENV DOCKER_HOST unix:///tmp/docker.sock
COPY --from=gobuild /docker-gen/dist/docker-gen /usr/local/bin/docker-gen

ENTRYPOINT ["/usr/local/bin/docker-gen"]
