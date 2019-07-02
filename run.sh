#!/bin/sh

set -e -x

clang -c -o main.o main.c
clang -o testcase -flto=thin main.o aliases.bc
./testcase
