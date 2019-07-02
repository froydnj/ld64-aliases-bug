#include <stdio.h>

extern int f1() __attribute__((visibility("hidden")));
extern int f2() __attribute__((visibility("hidden")));
extern int g(int);

int main()
{
  printf("f1: %d\n"
	 "f2: %d\n"
	 "g: %d\n",
	 f1(),
	 f2(),
	 g(25));
  return 0;
}
