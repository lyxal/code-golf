FROM debian:stretch-slim

ENV CGO_ENABLED=0 GOROOT_BOOTSTRAP=/usr/local/go

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl git make

# https://golang.org/dl/
RUN curl -SSL https://dl.google.com/go/go1.12.4.linux-amd64.tar.gz \
  | tar -xzC /usr/local

RUN git clone https://go.googlesource.com/go \
 && cd go                                    \
 && git checkout 68d4b12                     \
 && cd src                                   \
 && ./make.bash                              \
 && chmod +rx /root

ENV GOCACHE=/code-golf/.cache GOPATH=/code-golf/.path PATH=/go/bin:$PATH

CMD go build -ldflags -s
