FROM muslcc/x86_64:x86_64-linux-musl AS build

RUN apk upgrade -U -a

RUN apk add make git patch texinfo
WORKDIR /opt
RUN git clone https://github.com/richfelker/musl-cross-make

WORKDIR /opt/musl-cross-make
ADD config.mak config.mak

RUN make -j 8 > /dev/null
RUN make install
ADD postinstall.sh postinstall.sh
RUN sh postinstall.sh
ADD musl-autoprefix.sh output/script/musl-static-autoprefix.sh

FROM fedora:34

COPY --from=build /opt/musl-cross-make/output/ /opt/musl-static-toolchain/

RUN dnf group install -y "C Development Tools and Libraries" "Development Tools"
RUN dnf install -y wget

