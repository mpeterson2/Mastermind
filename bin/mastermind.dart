import "package:mastermind/mastermind.dart";
import "command-line-app.dart";

void main(List<String> args) {
  
  CommandLineApp cl = new CommandLineApp(args);
  
  Mastermind mm = new Mastermind(cl.codeToBreak, cl.maxValue);
  
  for(int i=0; i<mm.guesses.length - 1; i++) {
    print("Guess #${i+1}: ${mm.guesses[i]}");
    print("\t Correct Hits: ${mm.matchCorrects[i]}");
    print("\t Close Hits: ${mm.matchCloses[i]}\n");
  }
  
  if(mm.guessed) {
    print("Guessed the code in ${mm.guesses.length} tries.");
    print("The code was: ${mm.answer}");
  }
}