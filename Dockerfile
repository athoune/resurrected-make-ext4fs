FROM debian:12-slim AS build
RUN apt-get update && apt-get install -y \
    debmake \
    android-libsparse-dev \
    android-libselinux-dev \
    android-libcutils-dev \
    android-platform-system-core-headers \
    dh-exec \
    pandoc \
    libf2fs-dev \
    libf2fs-format-dev

RUN mkdir -p /src && \
    chmod 777 /src

USER nobody
WORKDIR /src

RUN git clone https://salsa.debian.org/android-tools-team/android-platform-system-extras.git && \
    mv android-platform-system-extras android-platform-system-extras_8.1.0+r23 && \
    cd android-platform-system-extras_8.1.0+r23 && \
    git checkout debian/8.1.0+r23-3 && \
    cd /src && \
    tar -cvzf android-platform-system-extras-8.1.0+r23.tar.gz android-platform-system-extras_8.1.0+r23

WORKDIR /src/android-platform-system-extras_8.1.0+r23
RUN rm -rf debian/out/* && \
    debmake && \
    dpkg-buildpackage && \
    ls /src

FROM debian:12-slim
COPY --from=build /src/*.deb /src/
RUN ls src && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        android-libselinux \
        android-libsparse \
        android-libcutils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && dpkg -i /src/android-libext4-utils_8.1.0+r23-3_amd64.deb \
    && dpkg -i /src/android-sdk-ext4-utils_8.1.0+r23-3_amd64.deb
