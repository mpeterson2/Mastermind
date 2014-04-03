import "package:unittest/unittest.dart";
import "package:mastermind/mastermind.dart";

void main() {
  test("Code Solutions", testSolutions);
  test("Code Breaker", testBreaker);
}

/**
 * Be sure solutions are unique and match each other correctly.
 */
void testSolutions() {
  List<List<int>> allSolutionsList = Permutation.permutate(5, 4);
  List<Code> allSolutions = new List<Code>();
  for(List<int> list in allSolutionsList) {
    allSolutions.add(new Code(list));
  }
  
  expect(allSolutions.length, equals(1296));
  
  // Test unique.
  for(int i=0; i<allSolutions.length; i++) {
    for(int j=0; j<allSolutions.length; j++) {
      if(i != j) {
        if(allSolutions[i] == allSolutions[j])
          fail("Solution $i was equal to $j");
      }
    }
  }
  
  // Test matching close/correct methods.
  for(int i=0; i<allSolutions.length; i++) {
    for(int j=0; j<allSolutions.length; j++) {
      Code solutionA = allSolutions[i];
      Code solutionB = allSolutions[j];
  
      
      int correctA = solutionA.matchCorrect(solutionB);
      int correctB = solutionB.matchCorrect(solutionA);
      expect(correctA, equals(correctB));
      
      int closeA = solutionA.matchClose(solutionB);
      int closeB = solutionB.matchClose(solutionA);
      expect(closeA, equals(closeB));
    }
  }
}

/**
 * Be sure every code can be broken in 10 tries.
 */
void testBreaker() {
  List<List<int>> allCodeList = Permutation.permutate(5, 4);
  
  for(List<int> codeList in allCodeList) {
    Code codeToBreak = new Code(codeList);
    CodeBreaker breaker = new CodeBreaker(5, 4);
    Code guess;
    
    for(int i=0; i<10; i++) {
      guess = breaker.makeGuess();
      
      if(guess == codeToBreak) {
        break;
      }
      
      int matchCorrect = guess.matchCorrect(codeToBreak);
      int matchClose = guess.matchClose(codeToBreak);
      
      breaker.giveFeedback(matchCorrect, matchClose);
    }
    
    expect(guess, equals(codeToBreak));    
  }
}