# Resurrected make_ext4fs

For Android 7, Google explored [deterministic file system creation](https://source.android.com/docs/core/ota/reduce_size).
This day, Android used ext4 (the mainstream Linux file system), and provide [make_ext4fs](https://android.googlesource.com/platform/system/extras/+/android-7.0.0_r3/ext4_utils/make_ext4fs.c).
Recent Android version use [F2FS](https://en.wikipedia.org/wiki/F2FS), a file system conceived for flash storage, not plain rotating disks storage.

Recent Android use _bazel_, making code reusing harder, and `make_ext4fs` vanished.

Some forks appears, and [OpenWRT's fork](https://git.openwrt.org/?p=project/make_ext4fs.git;a=summary) has also fresh patches.

## Flavors

### Debian package

Debian 8 did a tedious work of packaging android tools, dispatched in lots of packages.
Ascendent compatibility has real meaning with Debian packaging : it's possible to rebuild this package done for Debian 8, in a Debian 12.

### OpenWRT fork

OpenWRT eradicate all dependencies and boring stuffs.
The project is now a bunch of C file, handled by a plain old _Makefile_.
The unique dependency is `zlib`, and you can statically linked it.
Even `glibc` is not a dependency, you can use `musl`.

## Build it

Here is two Dockerfiles to build `make_ext4fs`.

```bash
# git, make, and that's all
make build-openwrt
# The Debian danse for build the old package and installing it
make build-debian
# You can fetch built debian packages
make deb
```
