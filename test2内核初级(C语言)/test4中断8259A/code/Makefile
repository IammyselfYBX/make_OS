.PHONY=all mv
all:mbr.bin loader.bin kernel.bin
	@echo "SUCCEED"
mbr.bin:boot/mbr.S 
	nasm -I boot/include/ boot/mbr.S -o mbr.bin

loader.bin:boot/loader.S
	nasm -I boot/include/ boot/loader.S -o loader.bin

kernel.bin:main.o init.o interrupt.o print.o kernel.o
	ld -m elf_i386 $^ -Ttext 0xc0001500 -e main -o kernel.bin
	@-rm *.o

print.o:lib/kernel/print.S
	nasm -f elf lib/kernel/print.S -o print.o
kernel.o:kernel/kernel.S 
	nasm -f elf kernel/kernel.S -o kernel.o
main.o:kernel/main.c
	gcc -m32 -I lib/kernel/ -I lib/ -c -fno-builtin kernel/main.c -o main.o
interrupt.o:kernel/interrupt.c
	gcc -m32 -I lib/kernel/ -I lib/ -c -fno-builtin -fno-stack-protector kernel/interrupt.c -o interrupt.o
init.o:kernel/init.c 
	gcc -m32 -I lib/kernel/ -I lib/ -c -fno-builtin kernel/init.c -o init.o

mv_env:mbr.bin loader.bin
	mv mbr.bin loader.bin kernel.bin ../Env

clean:
	@-rm *.o *.bin