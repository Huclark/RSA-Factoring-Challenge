#!/usr/bin/python3

import random
import math
from sys import argv, stderr


def isprime(number):
    if number < 2:
        return False
    result = int(math.sqrt(number)) + 1
    for i in range(2, result):
        if number % i == 0:
            return False
    return True


def sieve_of_eratosthenes(limit):
    primes = [2]
    sieve = [True] * (limit + 1)
    result = int(math.sqrt(limit)) + 1
    for num in range(3, result, 2):
        if sieve[num]:
            primes.append(num)
            mul = num * num
            limit_result = limit + 1
            numtwo = num * 2
            for multiple in range(mul, limit_result, numtwo):
                sieve[multiple] = False
    return primes


def generate_prime(min_value, max_value):
    prime = random.randint(min_value, max_value)
    while not isprime(prime):
        prime = random.randint(min_value, max_value)
    return prime


def mod_inverse(e, phi):
    for d in range(3, phi):
        if (d * e) % phi == 1:
            return d
    raise ValueError("mod_inverse does not exist")

def factorize(n):
    i = 2
    m = i * i
    while m <= n:
        if n % i == 0:
            return i, n // i
        i += 1
        
    return n, 1
    
if __name__ == "__main__":
    if len(argv) < 2:
        stderr.write("Usage: ./factors <file>\n")
        exit(1)

    file = argv[1]

    try:
        limit = 1000000
        primes = sieve_of_eratosthenes(int(math.sqrt(limit)))

        with open(file, 'r') as file:
            for line in file:
                number = int(line)
                p, q = factorize(number)
                print("{}={}*{}".format(number, q, p))
    except FileNotFoundError:
        stderr.write("Can't open file: {}\n".format(file))
        exit(1)
    except PermissionError:
        stderr.write("Permission Denied\n")
        exit(1)
