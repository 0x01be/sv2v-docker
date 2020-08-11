FROM 0x01be/haskell as builder

RUN apk add --no-cache --virtual sv2v-build-dependencies \
    git

RUN git clone --depth 1 https://github.com/zachjs/sv2v /sv2v

WORKDIR /sv2v

RUN stack --resolver nightly-2020-08-10 --system-ghc install

FROM alpine

COPY --from=builder /root/.local/bin/ /opt/sv2v/bin/

RUN apk add --no-cache --virtual sv2v-runtime-dependencies \
    gmp

ENV PATH $PATH:/opt/sv2v/bin/

VOLUME /workspace
WORKDIR /workspace

