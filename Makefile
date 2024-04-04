build:
	docker image build -t make_ext4 .

deb:
	mkdir -p ./out
	docker run -ti --rm -v `pwd`/out:/out make_ext4 sh -c "cp /src/*.deb /out/"
