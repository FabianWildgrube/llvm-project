../build/bin/clang -emit-llvm -target riscw-elf -c test.c -o testMine.bc
../build/bin/llc -march=riscw -debug-only=riscw-isel -filetype=asm testMine.bc -o test.S