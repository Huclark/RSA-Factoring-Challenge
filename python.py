#!/usr/bin/python3

from sys import argv, stderr, exit

def isprime(number):
	"""Checks if a number is a prime number
	Args:
		number: Number to inspect
	Returns: True if number is prime or False if otherwise
	"""
	i = 2
    
	while i < number:
		if number % i == 0:
			return False
		i += 1
        
	return True

def execute(buffer):
	"""Factorizes as many numbers as possible from a file into a product
	of two smaller numbers and prints result to stdout
	Args:
		Buffer: Buffer containing input from file
	"""
	number = int(buffer)
	i = 2

	while i < number:
		if number % i == 0:
			if isprime(i):
				print("{}={}*{}".format(number, number // i, i))
				return
		i += 1

	print("{}={}*{}".format(number, number, 1))

if __name__ == "__main__":
    """Reads from file and factorizes numbers in file
    """
    if len(argv) < 2:
        stderr.write("Usage: ./factors <file>\n")
        exit(1)
    
    file = argv[1]
    
    try:
        with open(file, 'r') as file:
            for line in file:
                execute(line.rstrip())
    except FileNotFoundError:
        stderr.write("Can't open file: {}\n".format(file))
        exit(1)
    except PermissionError:
        stderr.write("Permission Denied\n")
        exit(1)
