This is a self-contained testcase for an `ld64` bug with symbol aliases;
it is a reduced testcase for problems we observed in Firefox.

The `aliases.ll` file contains LLVM assembly.  You may need to tweak the
target of `aliases.ll` to make the LTO link, below, work
properly.  `main.c` has calls to all the of the functions contained in
`aliases.ll`.

`run.sh` compiles the appropriate files, links with `-flto=thin`, and
runs the testcase.  The expected output is:

```
f1: 5
f2: 5
g: 42
```

The output on my machine, using an `ld64` with the bug, is:

```
f1: 5
f2: 18
g: 42
```

YMMV.  The core problem can be seen from looking at the symbol table of
the testcase:

```
jubilee:linker-bug froydnj$ nm testcase
0000000100000000 T __mh_execute_header
0000000100000f60 T _f1
0000000100000f70 t _f2
0000000100000f70 t _g
0000000100000f20 T _main
                 U _printf
                 U dyld_stub_binder
```

We would expect that `_f1` and `_f2` have identical addresses, given the
`aliases.ll` file.  The actual result is that `_f2` and `_g` have
identical addresses, with predictably bad results when those functions
are actually used.
