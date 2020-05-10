#!/bin/sh
dd if=./mbr.bin of=./hd10M.img bs=512 count=1  conv=notrunc
