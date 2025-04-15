#!/bin/bash
set -xue

# path to  QEMU 
QEMU=qemu-system-riscv32
OBJCOPY=llvm-objcopy

# Путь к clang и его флагам
CC=clang  # Для Ubuntu: используйте CC=clang
CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 -ffreestanding -nostdlib"
SOURCE_FILES="src/kernel.c src/sbi.c src/string.c src/common.c src/memory.c"


# Сборка оболочки (приложения)
$CC $CFLAGS -Wl,-Tuser.ld -Wl,-Map=shell.map -o shell.elf src/shell.c src/user.c src/common.c
$OBJCOPY --set-section-flags .bss=alloc,contents -O binary shell.elf shell.bin
$OBJCOPY -Ibinary -Oelf32-littleriscv shell.bin shell.bin.o

# Сборка ядра
$CC $CFLAGS -Wl,-Tkernel.ld -Wl,-Map=kernel.map -o kernel.elf \
    $SOURCE_FILES shell.bin.o

# run QEMU
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot \
    -kernel kernel.elf