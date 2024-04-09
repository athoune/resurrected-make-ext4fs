FROM debian:12-slim as build

RUN apt-get update && apt-get install -y \
        build-essential\
        git \
        zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /src && \
    chmod 777 /src

USER nobody

WORKDIR /src
RUN git clone https://git.openwrt.org/project/make_ext4fs.git

WORKDIR /src/make_ext4fs
RUN make

FROM debian:12-slim

COPY --from=build /src/make_ext4fs/make_ext4fs /usr/bin/make_ext4fs

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fuse \
        fuse2fs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
