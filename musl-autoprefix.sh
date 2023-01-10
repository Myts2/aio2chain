#!/usr/bin/env bash

if [[ "x$BASH_SOURCE" = x"" ]]
        then BASH_SOURCE=$0
fi

SCRIPT=$(readlink -f "$BASH_SOURCE")
SCRIPTPATH=$(dirname "$SCRIPT")
INSTALLPATH=$(dirname "$SCRIPTPATH")

SYSROOT="${INSTALLPATH}/x86_64-linux-musl/"
PREFIX="${SYSROOT}/usr"

NEW_PATH="${INSTALLPATH}/bin:${SYSROOT}/sbin"
case ":${PATH:=$NEW_PATH}:" in
    *:${NEW_PATH}:*)  ;;
    *) PATH="${NEW_PATH}:${PATH}"  ;;
esac

export PATH="${PATH}"
export CC="gcc -static --static --sysroot=${SYSROOT}"
export CXX="g++ -static --static --sysroot=${SYSROOT}"
export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig"
export LIBRARY_PATH="${PREFIX}/lib"
export LDFLAGS="-static --static"
export CPPFLAGS="-static --static --sysroot=${SYSROOT}"
export CFLAGS="${CPPFLAGS} -march=x86-64 -fPIC $2"
export CXXFLAGS="${CFLAGS}"

export PREFIX="${PREFIX}"
export CONFIG_SITE="${INSTALLPATH}/config.site"
echo "prefix=${PREFIX}" > "${INSTALLPATH}/config.site"
