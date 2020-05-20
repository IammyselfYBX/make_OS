.PHONY=all mv
all:mbr.bin loader.bin kernel.bin
	@echo "SUCCEED"
mbr.bin:boot/mbr.S 
	nasm -I boot/include/ boot/mbr.S -o mbr.bin

loader.bin:boot/loader.S
	nasm -I boot/include/ boot/loader.S -o loader.bin

kernel.bin:kernel/main.c
	gcc -c kernel/main.c -o main.o
	ld main.o -Ttext 0xc0001500 -e main -o kernel.bin
	@rm main.o

mv_env:mbr.bin loader.bin
	mv mbr.bin loader.bin kernel.bin ../Env

clean:
	@-rm loader.bin mbr.bin kernel.bin