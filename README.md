Mastermind
==========

A Mastermind solver.

## Setup

### Install Dart

To use this application, you must have [Dart](https://www.dartlang.org/) installed. In order to do this, follow these [instructions](https://www.dartlang.org/tools/download.html).

- Download the [Dart bundle](https://www.dartlang.org/tools/download.html).
- Extract the contents to any location on your disk.
- Add the Dart SDK to your path. The SDK is found in the folder you extracted.
- Dart should now be installed.

### Setup the application

- Download the repository to any location.
- Change directories to the root of the project.
- Run `pub get` to install the dependencies.
- You should be able to run it now.

## How to use

### Command Line App

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

#### Max Value

The default value for the max number is 6, although you can change this. You can do this using the argument `--max <int>` or `-m <int>` before the code.

Here's an example with the maximum value of `4` and the code of `1, 4, 2, 1`:

```
$ dart mastermind.dart -m 4 1 4 2 1
Guess #1: 0, 0, 1, 2.
	Correct hits: 0
	Close hits  : 2
Guess #2: 2, 3, 4, 1.
	Correct hits: 1
	Close hits  : 2
Guess #3: 3, 1, 2, 1.
	Correct hits: 2
	Close hits  : 1
Guess #4: 2, 1, 2, 3.
	Correct hits: 1
	Close hits  : 1
Guessed it in 5 tries. The code was: 1, 4, 2, 1

```

### Server App

#### Dartium

- For Dartium, uncomment line 20 and comment out line 21 in `lib/server/server-app.dart`
- Run `bin/dart-server.dart`
- Navagate to `localhost:9000`

#### Other browsers

 - For other browsers, supported by Dart, run `pub build` over the directory containing `pubspec.yaml`. This will compile the Dart code into JavaScript.
 - Run `dart bin/mastermind-server.dart`.
 - Navagate to `localhost:9000`

## Tests

To run the tests, simple run `dart tests/test.dart`.
