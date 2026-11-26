# klipperpress

Build Klipper firmware for one of the configurations in `conf/` with either
the Alpine- or Debian-based image.

```sh
# Alpine
docker build \
  --build-arg BUILD_CONFIG_FILE=btteddy_usb.conf \
  --output=out/alpine .

# Debian
docker build \
  --file=Dockerfile.debian \
  --build-arg BUILD_CONFIG_FILE=btteddy_usb.conf \
  --output=out/debian .
```

Set `--build-arg KLIPPER_TAG=<branch-or-tag>` to build a Klipper revision
other than `master`.