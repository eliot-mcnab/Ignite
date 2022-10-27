#include "stdio.h"

void greet(char* message) {
	printf("%s\n", message);
}

int main (int argc, char *argv[])
{
	greet("Hello World !");
	return 0;
}
