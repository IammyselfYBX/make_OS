.PHONY=all mv
all:mbr.bin loader.bin kernel.bin
	@echo "SUCCEED"
mbr.bin:boot/mbr.S 
	nasm -I boot/include/ boot/mbr.S -o mbr.bin

loader.bin:boot/loader.S
	nasm -I boot/include/ boot/loader.S -o loader.bin
print.o:lib/kernel/print.S
	nasm -f elf lib/kernel/print.S -o print.o

kernel.bin:kernel/main.c print.o 
	gcc -m32 -I lib/kernel/ -c kernel/main.c -o main.o
	ld -m elf_i386 main.o print.o -Ttext 0xc0001500 -e main -o kernel.bin
	@rm main.o print.o

mv_env:mbr.bin loader.bin
	mv mbr.bin loader.bin kernel.bin ../Env

clean:
	@-rm loader.bin mbr.bin kernel.bin main.o print.o