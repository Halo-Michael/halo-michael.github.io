#!/bin/bash
rm -rf Packages Packages.bz2 Packages.xz Packages.lzma
dpkg-scanpackages -m ./debs /dev/null >Packages
bzip2 -9fkv Packages > Packages.bz2
xz -9fkev Packages > Packages.xz
xz -9fkev --format=lzma Packages > Packages.lzma

