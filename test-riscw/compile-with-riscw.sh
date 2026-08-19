../build/bin/clang -O2 -emit-llvm -target riscw-elf -c test.c -o testMine.bc
../build/bin/llc -march=riscw -O2 -debug-only=riscw-isel -filetype=asm testMine.bc -o test.S