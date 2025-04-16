#!/bin/bash
set -xue

# path to  QEMU 
QEMU=qemu-system-riscv32
OBJCOPY=llvm-objcopy

# Путь к clang и его флагам
CC=clang  # Для Ubuntu: используйте CC=clang
CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 -ffreestanding -nostdlib"
SOURCE_FILES=$(find src/common -name "*.c" | paste -sd " ")

# Сборка оболочки (приложения)
SHELL_SOURCE_FILES=$(find src/apps/shell -name "*.c" | paste -sd " ")
$CC $CFLAGS -Wl,-Tuser.ld -Wl,-Map=shell.map -o shell.elf -I src/common $SOURCE_FILES $SHELL_SOURCE_FILES
$OBJCOPY --set-section-flags .bss=alloc,contents -O binary shell.elf shell.bin
$OBJCOPY -Ibinary -Oelf32-littleriscv shell.bin shell.bin.o

# Сборка ядра
KERNEL_SOURCE_FILES=$(find src/kernel -name "*.c" | paste -sd " ")
$CC $CFLAGS -Wl,-Tkernel.ld -Wl,-Map=kernel.map -o kernel.elf \
    -I src/common $SOURCE_FILES $KERNEL_SOURCE_FILES shell.bin.o

# run QEMU
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot \
    -kernel kernel.elf