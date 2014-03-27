Mastermind
==========

A Mastermind solver.

# How to use

You can run it as a Dart application by running the file `bin/mastermind.dart`, and including your code separated by spaces afterwords.

Here's an example with the code `0, 0, 1, 2`:

```
dart mastermind.dart 0 0 1 2
Guess #1: 0, 0, 1, 1.
	Correct hits: 3
	Close hits  : 1
Guess #2: 0, 2, 1, 1.
	Correct hits: 2
	Close hits  : 3
Guess #3: 0, 0, 2, 1.
	Correct hits: 2
	Close hits  : 2
Guessed it in 4 tries. The code was: 0, 0, 1, 2

```

# Current issues

- Close hits are not correct. It still guesses the correct code though.
