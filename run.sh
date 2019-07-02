#!/bin/sh

set -e

clang -c -x ir -emit-llvm -o aliases.bc aliases.ll
clang -c -o main.o main.c
clang -o testcase -flto=thin main.o aliases.bc
./testcase
