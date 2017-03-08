
all	: boot

TOOLS_DIR=/Users/tom/projects/build_gcc_crosscompiler/binary/sparc-elf/bin

AS=$(TOOLS_DIR)/sparc-elf-as
LD=$(TOOLS_DIR)/sparc-elf-ld
DD=dd
MKISOFS=mkisofs

boot: boot.s
	$(AS) boot.s -o boot.o
	$(LD) boot.o -o boot.bin -T boot.ld
clean:
	rm *.o
	rm *.bin
