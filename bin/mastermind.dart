library Mastermind;

import "dart:io";
import "dart:math";
import "package:args/args.dart";

part "code.dart";
part "code-breaker.dart";
part "permutation.dart";

void main(List<String> args) {
  // Start getting the command line args.
  ArgParser parser = _getParser();
  ArgResults argResults = parser.parse(args);
  
  // Print the usage if it is requested.
  requestHelp(parser, argResults);
  
  // Get the code and the max value of the code.
  int maxValue = getMaxValue(argResults);
  List<int> inputCode = getCode(argResults, maxValue);
  
  // userCode is the code the program is trying to crack.
  // This is only used to see if the guessed code is correct, and to provide
  // feedback to the CodeBreaker, so the user doesn't have to do it.
  Code userCode = new Code(inputCode);
  
  // Create the object that will break the code.
  CodeBreaker cb = new CodeBreaker(maxValue, userCode.length);
  
  // This will become true when the code is cracked.
  bool guessed = false;
  
  // Try 10 times at the most to guess the code.
  for(int i=0; i<10; i++) {
    // Guess a number.
    Code guess = cb.guessNumber();
    
    // If the number was guessed, tell the user.
    if(guess == userCode) {
      print("Guessed it in ${i+1} tries. The code was: $guess");
      guessed = true;
      break;
    }
    
    // If the number was not guessed, give the CodeBreaker
    // feedback and try again.
    else {
      int numCorrect = userCode.numCorrect(guess);
      int numClose = userCode.numClose(guess);
      print("Guess #${i + 1}: $guess.");
      print("\tCorrect hits: $numCorrect");
      print("\tClose hits  : $numClose");
      
      cb.giveFeedback(numCorrect, numClose);
    }
  }
  
  // If it somehow manages to fail, let the user know.
  if(!guessed) {
    print("The program has failed to guess the code in under 10 tries.");
  }
}

/**
 * Get the argument parser.
 * 
 * The only real argument is the max value (`max`, `m`).
 */
ArgParser _getParser() {
  return new ArgParser()
    ..addOption("max", abbr: "m", help: "Set the max value of the code", defaultsTo: "5");
}

/**
 * Will print Mastermind's usage if it was requested by the `help` argument.
 */
void requestHelp(ArgParser parser, ArgResults results) {
  if(results.command != null && results.command.name == "help") {
    print("Mastermind Usage: ");
    print(parser.getUsage);
    return;
  }  
}

/**
 * Will return the max value for the code.
 * 
 * If the user didn't supply one, this will return the default of 6.
 * If this fails, it will tell the user and close the program.
 */
int getMaxValue(ArgResults argResults) {
  // The max value defaults to 6.
  int maxValue = 6;
  // Try to grab the max value.
  try {
    maxValue = int.parse(argResults["max"]);
    if(maxValue < 1)
      throw new Exception();
  } catch(e) {
    // Tell the user that they provided bad input, and exit.
    print("The max value must be an integer greater than 1.");
    exit(1);
  }
  return maxValue;
}

/**
 * Will return the code that the user supplied, using the leftover args.
 * 
 * If this fails, it will tell the user and close the program.
 */
List<int> getCode(ArgResults argResults, int maxValue) {
  List<int> inputCode = new List<int>();
  // Try to go through the rest of the args and add them to the code.
  try {
    for(String s in argResults.rest) {
      int addInt = int.parse(s);
      if(addInt > maxValue || addInt < 0)
        throw new Exception();
      inputCode.add(addInt);
    }
  } catch(e) {
    // Tell the user that they provided bad input, and exit.
    print("The code must be an integer greater than 0 and less than $maxValue");
    exit(1);
  }
  
  // Be sure the code is long enough.
  if(inputCode.length < 2) {
    print("The code must be at least 2 digits.");
    exit(1);
  }
  
  return inputCode;
}