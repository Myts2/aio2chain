#!/bin/sh

mkdir -p output/x86_64-linux-musl/usr/lib
cd output/x86_64-linux-musl/usr; ln -s lib lib64;
cd ../../../;
cd output/bin ; for file in *; do ln -s $file ${file/*x86_64-linux-musl-/} || true; done
