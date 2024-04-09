build-openwrt:
	docker image build -t make_ext4fs:openwrt OpenWRT

build-debian:
	docker image build -t make_ext4fs:debian Debian

build-all: build-openwrt build-debian

deb: build-debian
	mkdir -p ./out
	docker run -ti --rm -v `pwd`/out:/out make_ext4 sh -c "cp /src/*.deb /out/"
