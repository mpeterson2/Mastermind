library Mastermind;

import "dart:math";

part "code.dart";
part "code-breaker.dart";
part "permutation.dart";

void main(List<String> args) {  
  // Be sure the user supplied at least two digits for the code.
  if(args.length < 2) {
    print("The Code must be at least 2 digits long.");
    return;
  }
  
  // Create the actual code.
  List<int> inputCode = new List();
  for(String arg in args) {
    // Try to parse the info, but don't trust the user to give you correct input.
    try {
      // Parse the digit to add and if it's a good value, add it.
      int digitToAdd = int.parse(arg);
      if(digitToAdd <= Code.MAX_VAL && digitToAdd >= 0)
        inputCode.add(digitToAdd);
      else
        throw new Exception();
      
      // If the user supplied bad input, tell them.
    } catch(e) {
      print("The code can only be single digit numbers, from 0 - ${Code.MAX_VAL}");
      return;
    }
  }
  
  Code userCode = new Code(inputCode);
  
  // Create the object that will break the code.
  CodeBreaker cb = new CodeBreaker(Code.MAX_VAL, userCode.length);
  
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
      
      cb.giveFeedback(numCorrect, numClose);
    }
  }
  
  // If it somehow manages to fail, let the user know.
  if(!guessed) {
    print("The program has failed to guess the code in under 10 tries.");
  }
}