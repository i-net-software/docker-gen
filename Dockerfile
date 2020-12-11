FROM golang as gobuild
RUN go get github.com/i-net-software/docker-gen/cmd/docker-gen

FROM alpine:latest
LABEL maintainer="Jason Wilder <mail@jasonwilder.com>"

RUN apk -U add openssl libc6-compat

ENV DOCKER_HOST unix:///tmp/docker.sock
COPY --from=gobuild /go/bin/docker-gen /usr/local/bin/docker-gen

ENTRYPOINT ["/usr/local/bin/docker-gen"]
