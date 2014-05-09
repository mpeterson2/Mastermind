import "dart:html";
import "dart:convert";
import "package:mastermind/mastermind.dart";

void main() {
  TextInputElement code = querySelector("#codeInput");
  querySelector("#guessCodeServer")
      .onClick.listen((e) => guessCodeServerSide(code.value));
  
  querySelector("#guessCodeClient")
      .onClick.listen((e) => guessCodeClientSide(code.value));
    
}

void guessCodeServerSide(String code) {
  DateTime startTime = new DateTime.now();
  HttpRequest.request("/guess?code=$code")
    .then((HttpRequest request) {
      DateTime endTime = new DateTime.now();
      
      Map response = JSON.decode(request.responseText);
      Code answer = new Code(response["answer"]);
      List<List<int>> guessDigits = response["guesses"];
      List<Code> guesses = guessDigits.map((List<int> digits) => new Code(digits)).toList();
      List<int> closes = response["closes"];
      List<int> corrects = response["corrects"];
     
      displayResults(answer, guesses, closes, corrects, endTime.difference(startTime));
  });
}

void guessCodeClientSide(String codeStr) {
  DateTime startTime = new DateTime.now();
  Code code = new Code.fromStr(codeStr);
  Mastermind mm = new Mastermind(code);
  DateTime endTime = new DateTime.now();
  displayResults(mm.answer, mm.guesses, mm.matchCloses, mm.matchCorrects, endTime.difference(startTime));
}

void displayResults(Code answer, List<Code> guesses, List<int> closes, List<int> corrects, Duration timeTook) {
      DivElement answerDiv = querySelector("#answerDiv");
      answerDiv.children.clear();
      answerDiv
          ..append(new BRElement())
          ..appendHtml("Time taken: ${timeTook.inMilliseconds}ms")
          ..append(new BRElement())
          ..append(new BRElement())
          ..appendHtml("Number of guesses: ${guesses.length}")
          ..append(new BRElement());

      for(int i=0; i<guesses.length - 1; i++) {
        answerDiv
            ..append(new BRElement())
            ..appendHtml("Guess ${i + 1}: [${guesses[i]}]")
            ..append(new BRElement())
            ..appendHtml("Number of correct hits: ${corrects[i]}")
            ..append(new BRElement())
            ..appendHtml("Number of close hits:   ${closes[i]}")
            ..append(new BRElement());
      }
      
      answerDiv
          ..append(new BRElement())
          ..appendHtml("The correct code was: ${answer}");
}
















