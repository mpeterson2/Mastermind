Mastermind
==========

A Mastermind solver.

# How to use

You can run it as a Dart application by running the file `bin/mastermind.dart`, and including your code separated by spaces afterwords.

Here's an example with the code `0, 0, 1, 2`:

```
$ dart mastermind.dart 1 3 4 5
Guess #1: 0, 0, 1, 1.
	Correct hits: 0
	Close hits  : 1
Guess #2: 3, 2, 0, 2.
	Correct hits: 0
	Close hits  : 1
Guess #3: 2, 1, 4, 5.
	Correct hits: 2
	Close hits  : 1
Guess #4: 5, 1, 2, 5.
	Correct hits: 1
	Close hits  : 1
Guessed it in 5 tries. The code was: 1, 3, 4, 5
```