FROM 0x01be/haskell as builder

RUN apk add --no-cache --virtual build-dependencies \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    git

RUN git clone --depth 1 https://github.com/zachjs/sv2v /sv2v

WORKDIR /sv2v

RUN stack --resolver nightly-2020-07-30 --system-ghc install

FROM alpine:3.12.0

COPY --from=builder /root/.local/bin/ /opt/sv2v/bin/

RUN apk add --no-cache --virtual runtime-dependencies \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    gmp

ENV PATH $PATH:/opt/sv2v/bin/

