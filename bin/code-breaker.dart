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
  
  
  CodeBreaker(this.maxNum, this.codeLength) {
    firstGuess = true;
    _generatePossibleCodes();
  }
  
  Code guessNumber() {
    
    if(firstGuess) {
      // It's recommended to start out with [0, 0, 1, 1] for the normal problem,
      // which is number 7 in the array.
      if(possibleCodes.length >= 7)
        lastCode = possibleCodes[7];
      else
        lastCode = possibleCodes[possibleCodes.length ~/ 2];
      firstGuess = false;
    }
    else {
      // Pick the middle code.
      lastCode = possibleCodes[possibleCodes.length ~/ 2];
    }

    return lastCode;
  }
  

  void giveFeedback(int numCorrect, int numClose) {
    List<Code> badCodes = new List<Code>();
    
    // Check each code to see if it is still a possible code.
    // In order for this to happen, it needs to have the same amount of correct
    // and close matches to the guess, as the guess did to the correct code.
    for(Code code in possibleCodes) {
      int matchCorrect = lastCode.matchCorrect(code);
      int matchClose = lastCode.matchClose(code);
      
      if(matchCorrect != numCorrect || matchClose != numClose) {
        badCodes.add(code);
      }
    }
    
    for(Code code in badCodes) {
      possibleCodes.remove(code);
    }
  }
  
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
}