.PHONY=all mv
all:mbr.bin loader.bin
	@echo "SUCCEED"
mbr.bin:mbr.S 
	nasm -Iinclude/ mbr.S -o mbr.bin

loader.bin:loader.S
	nasm -Iinclude/ loader.S -o loader.bin

mv:mbr.bin loader.bin
	cp mbr.bin loader.bin ../Env

clean:
	@-rm loader.bin mbr.bin