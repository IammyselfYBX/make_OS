.PHONY=all mv
all:mbr.bin loader.bin
	@echo "SUCCEED"
mbr.bin:mbr.S 
	nasm -I include/ mbr.S -o mbr.bin

loader.bin:loader.S
	nasm -I include/ loader.S -o loader.bin

mv_env:mbr.bin loader.bin
	mv mbr.bin loader.bin ../Env

clean:
	@-rm loader.bin mbr.bin