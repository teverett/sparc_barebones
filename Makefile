
all	: boot

TOOLS_DIR=/Users/tom/projects/build_gcc_crosscompiler/binary/sparc-elf/bin

AS=$(TOOLS_DIR)/sparc-elf-as
LD=$(TOOLS_DIR)/sparc-elf-ld
DD=dd
MKISOFS=mkisofs

boot: boot.s
	$(AS) boot.s -o boot.o
	$(LD) boot.o -o boot.bin -T boot.ld
iso: boot
	$(DD) if=/dev/zero of=bootblock.bin bs=2048 count=4
	$(DD) if=boot.bin of=bootblock.bin bs=512 seek=1 conv=notrunc
	$(MKISOFS) -o helloworld.iso -G bootblock.bin
clean:
	rm *.o
	rm *.bin
