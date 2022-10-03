#include "stdio.h"
void test()
{
	int	i;

	i = -1;

	while (++i < 10) {
		printf("%d\n", i);
	}
}

int main (int argc, char *argv[])
{
	test();
	return 0;
}
