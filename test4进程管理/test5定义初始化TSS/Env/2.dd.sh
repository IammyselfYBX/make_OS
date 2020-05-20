#!/bin/sh
dd if=./mbr.bin of=./hd10M.img bs=512 count=1  conv=notrunc
echo "Finish MBR"
echo "---------------------------------------------"
dd if=./loader.bin of=./hd10M.img bs=512 count=4 seek=2 conv=notrunc
echo "Finish Loader"
echo "---------------------------------------------"
dd if=./kernel.bin of=./hd10M.img bs=512 count=200 seek=9 conv=notrunc  #第0～8个扇区不使用
echo "Finish Kernel"
echo "---------------------------------------------"
