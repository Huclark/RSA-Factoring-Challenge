#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

gcc -o factors -xc - << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

void execute(char *buffer);
int isprime(ssize_t number);

int main(int argc, char **argv)
{
    char *buffer = NULL;
    size_t n;
    FILE *file;

    if (argc < 2)
    {
        fprintf(stderr, "Usage: %s <file>\n", argv[0]);
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
    return EXIT_SUCCESS;
}

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

int isprime(ssize_t number)
{
    ssize_t i = 2;

    while (i < number)
    {
        if (number % i == 0)
            return 0;
        i++;
    }

    return 1;
}
EOF

./factors "$1"
