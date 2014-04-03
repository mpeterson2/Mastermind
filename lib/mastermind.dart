library Mastermind;

part 'src/code.dart';
part 'src/code-breaker.dart';
part 'src/permutation.dart';

class Mastermind {
  
  Code codeToBreak;
  CodeBreaker codeBreaker;
  List<Code> guesses;
  List<int> matchCorrects;
  List<int> matchCloses;
  Code answer;
  
  Mastermind(this.codeToBreak, [int maxNum = 6]) {
    codeBreaker = new CodeBreaker(maxNum, codeToBreak.length);
    guesses = new List<Code>();
    matchCorrects = new List<int>();
    matchCloses = new List<int>();
    _solve();
  }
  
  void _solve() {
    for(int i=0; i<10; i++) {
      Code guess = codeBreaker.makeGuess();
      guesses.add(guess);
      
      if(guess == codeToBreak) {
        answer = guess;
        break;
      }
      else {
        int matchCorrect = codeToBreak.matchCorrect(guess);
        int matchClose = codeToBreak.matchClose(guess);
        matchCorrects.add(matchCorrect);
        matchCloses.add(matchClose);
        codeBreaker.giveFeedback(matchCorrect, matchClose);
      }      
    }
  }
  
  bool get guessed {
    return guesses.last == codeToBreak;
  }
}