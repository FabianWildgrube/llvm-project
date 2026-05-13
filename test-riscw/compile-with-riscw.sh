../build/bin/clang -O2 -emit-llvm -target riscw-elf -c test.c -o testMine.bc
../build/bin/llc -march=riscv64 -O2 -filetype=asm testMine.bc -o test.S