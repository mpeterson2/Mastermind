part of Mastermind;

/**
 * The CodeBreaker will figure out what the code is.
 */
class CodeBreaker {
  
  List<Code> possibleCodes;
  int maxNum;
  int codeLength;
  Code lastCode;
  bool firstGuess;
  
  
  /**
   * Creates a CodeBreaker and generates the possible codes.
   */
  CodeBreaker(this.maxNum, this.codeLength) {
    firstGuess = true;
    _generatePossibleCodes();
  }
  
  /**
   * Guesses a new number.
   */
  Code guessNumber() {
    
    // If it is the first code, pick the recommended code to start with.
    if(firstGuess) {
      // It's recommended to start out with [0, 0, 1, 1] for the normal problem,
      // which is number 7 in the array. It seems to work well enough with all
      // the lengths as well.
      if(possibleCodes.length >= 7)
        lastCode = possibleCodes[7];
      else
        lastCode = possibleCodes[possibleCodes.length ~/ 2];
      firstGuess = false;
    }
    // Otherwise, pick the middle code.
    else {
      lastCode = possibleCodes[possibleCodes.length ~/ 2];
    }

    return lastCode;
  }
  
  /**
   * Give feedback to this CodeBreaker.
   * 
   * This function will remove all the codes that it cannot possibly be.
   */
  void giveFeedback(int numCorrect, int numClose) {
    // Save a list of bad codes to remove from the possibleCodes later.
    List<Code> badCodes = new List<Code>();
    
    // Check each code to see if it is still a possible code.
    // In order for this to happen, it needs to have the same amount of correct
    // and close matches to the guess, as the guess did to the correct code.
    for(Code code in possibleCodes) {
      // Get the matches.
      int matchCorrect = lastCode.numCorrect(code);
      int matchClose = lastCode.numClose(code);
      
      // If they are not equal, we need to save them to remove them.
      if(matchCorrect != numCorrect || matchClose != numClose) {
        badCodes.add(code);
      }
    }
    
    // Remove the bad codes form the list.
    for(Code code in badCodes) {
      possibleCodes.remove(code);
    }
  }
  
  /**
   * Generates every possible code in the problem.
  */
  void _generatePossibleCodes() {
    // Generate a permutation in the form of a list of list of ints. 
    possibleCodes = new List<Code>();
    List<List<int>> lists = Permutation.permutate(maxNum, codeLength);
    
    // Create the Codes out of the list.
    for(List<int> list in lists) {
      Code c = new Code(list);
      possibleCodes.add(c);
    }
  
  }
  
  /**
   * Generates every possible code in the problem.
   * 
   * This is how I had originally generated all the numbers. It worked,
   * but only for codes with a length of 4. I've ran into this situation
   * before, but I've never looked into it more. So I posted a question on
   * stackoverflow, and created my Permutation class from their help.
   * 
   */
  @deprecated
  void _generatePossibleCodesOld() {
    possibleCodes = new List<Code>();
    
    // Loop through MAX_VAL times, 4 times, in order to create a permutation of
    // 4 elements, with values from 0 to MAX_VAL.
    for(int i=0; i<=Code.MAX_VAL; i++) {
      for(int j=0; j<Code.MAX_VAL; j++) {
        for(int k=0; k<Code.MAX_VAL; k++) {
          for(int l=0; l<Code.MAX_VAL; l++) {
            Code c = new Code([i, j, k, l]);
            possibleCodes.add(c);
          }
        }
      }
    }
  }  
}