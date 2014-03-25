part of Mastermind;

/**
 * The CodeBreaker will figure out what the code is.
 */
class CodeBreaker {
  
  List<Code> possibleCodes;
  int maxNum;
  int codeLength;
  Code lastCode;
  bool first;
  
  
  /**
   * Creates a CodeBreaker and generates the possible codes.
   */
  CodeBreaker(this.maxNum, this.codeLength) {
    first = true;
    _generatePossibleCodes();
  }
  
  /**
   * Guesses a new number.
   */
  Code guessNumber() {
    
    // If it is the first code, pick the recommended code to start with.
    if(first) {
      // It's recommended to start out with [0, 0, 1, 1] for the normal problem,
      // which is number 7 in the array.
      lastCode = possibleCodes[7];
      first = false;
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
   * This is deprecated because there is no way to easily change
   * the max values or size of the code.
   * 
   */
  @deprecated
  void _generatePossibleCodesOld() {
    possibleCodes = new List<Code>();
    
    // Loop through 6 times, 4 times, in order to create a permutation of
    // 4 elements, with values from 0 to 6.
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