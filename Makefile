all:
	nasm -o kernel.bin boot.asm

clean:
	rm -rf *.o *.bin

boot:
	qemu-system-x86_64  kernel.bin

debug:
	qemu-system-x86_64 -s -S kernel.bin
	# Debug with 
	# (gdb) target remote localhost:1234
	# (gdb) set architecture i8086
	# (gdb) break *0x7c00
	# (gdb) cont