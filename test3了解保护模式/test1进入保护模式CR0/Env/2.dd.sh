#!/bin/sh
dd if=./mbr.bin of=./hd10M.img bs=512 count=1  conv=notrunc
dd if=./loader.bin of=./hd10M.img bs=512 count=4 seek=2 conv=notrunc