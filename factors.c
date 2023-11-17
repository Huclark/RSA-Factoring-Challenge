#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

void execute(char *buffer);
int isprime(ssize_t number);

/**
 * main - Entry point
 * @argc: Argument count
 * @argv: Argument vector
 * Return: Always 0 on success or 1 if otherwise
*/
int main(int argc, char **argv)
{
	char *buffer = NULL;
	size_t n;
	FILE *file;

	if (argc < 2)
	{
		fprintf(stderr, "Usage: ./factors <file>\n");
		exit(EXIT_FAILURE);
	}

	file = fopen(argv[1], "r");

	if (!file)
	{
		if (errno == EACCES)
		{
			fprintf(stderr, "Permission Denied\n");
			exit(EXIT_FAILURE);
		}
		fprintf(stderr, "Can't open file\n");
		exit(EXIT_FAILURE);
	}

	while (getline(&buffer, &n, file) != -1)
		execute(buffer);

	free(buffer);
	fclose(file);
	return (EXIT_SUCCESS);
}


/**
 * execute - Factorizes as many numbers as possible from a file into a product
 *           of two smaller numbers and prints result to stdout
 * @buffer: Buffer containing input from file
*/
void execute(char *buffer)
{
	ssize_t number;
	ssize_t i = 2;

	number = atol(buffer);

	while (i < number)
	{
		if (number % i == 0)
		{
			if (isprime(i))
			{
				printf("%ld=%ld*%ld\n", number, number / i, i);
				return;
			}
		}
		i++;
	}

	printf("%ld=%ld*%d\n", number, number, 1);
}


/**
 * isprime - Checks if a number is a prime number
 * @number: Number to inspect
 * Return: 1 if true or 0 if otherwise
*/
int isprime(ssize_t number)
{
	ssize_t i = 2;

	while (i < number)
	{
		if (number % i == 0)
			return (0);
		i++;
	}

	return (1);
}
