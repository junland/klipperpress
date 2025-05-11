FROM alpine:3.21 AS builder

ARG BUILD_CONFIG_FILE 

ENV KLIPPER_TAG=master

# Update the package index and install necessary packages
RUN apk update && apk add --no-cache \
    avrdude \
    bash \
    binutils-arm-none-eabi \
    binutils-avr \
    curl \
    dfu-util \
    gcc-arm-none-eabi \
    gcc-avr \
    git \
    build-base \
    newlib-arm-none-eabi \
    pkgconfig \
    python3

WORKDIR /opt

# Clone the repository
RUN git clone https://github.com/Klipper3d/klipper

WORKDIR /opt/klipper

# Checkout a tag or branch
RUN git fetch --tags && git checkout ${KLIPPER_TAG}

# Create a build_config directory
RUN mkdir -p /opt/klipper/build_config

# Copy firmware configuration files within conf directory to build_config
COPY conf /opt/klipper/build_config

# Set a link to the build_config file
RUN ln -sv /opt/klipper/build_config/${BUILD_CONFIG_FILE} /opt/klipper/.config

# Build the firmware
RUN make

FROM scratch

# Copy all files from the out directory of the builder stage
COPY --from=builder /opt/klipper/out/ .