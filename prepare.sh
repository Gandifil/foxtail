apt update && sudo apt install -y clang llvm lld qemu-system-riscv32 curl
clang -print-targets | grep riscv32
echo "If a last command returned 'riscv32     - 32-bit RISC-V' all're good!"