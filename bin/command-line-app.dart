import "dart:io";
import "package:args/args.dart";
import "package:mastermind/mastermind.dart";

class CommandLineApp {

  ArgParser _parser;
  ArgResults _results;
  
  int maxValue;
  Code codeToBreak;
  
  CommandLineApp(List<String> args) {
    _setupParser();
    _results = _parser.parse(args);
    _requestHelp();
    maxValue = _getMaxValue();
    codeToBreak = _getCode();
  }
  
  void _setupParser() {
    _parser = new ArgParser()
      ..addOption("max", abbr: "m", help: "Set the max value of the code.", defaultsTo: "5")
      ..addFlag("help", abbr: "h", help: "Prints usage.", defaultsTo: false, negatable: false);
  }
  
  void _requestHelp() {
    if(_results["help"]) {
      print("Mastermind Usage: ");
      print(_parser.getUsage());
      exit(0);
    }  
  }
  
  int _getMaxValue() {
    int maxValue = 6;
    
    try {
      maxValue = int.parse(_results["max"]);
      if(maxValue < 1)
        throw new Exception();
    } catch(e) {
      print("The max value must be an integer greater than 1.");
      exit(1);
    }
    return maxValue;
  }
  
  Code _getCode() {
    List<int> inputCode = new List<int>();
    // Try to go through the rest of the args and add them to the code.
    try {
      for(String s in _results.rest) {
        int addInt = int.parse(s);
        if(addInt > maxValue || addInt < 0)
          throw new Exception();
        inputCode.add(addInt);
      }
    } catch(e) {
      print("The code must be an integer greater than 0 and less than $maxValue");
      exit(1);
    }
    
    // Be sure the code is long enough.
    if(inputCode.length < 2) {
      print("The code must be at least 2 digits.");
      exit(1);
    }
    
    return new Code(inputCode);
  }
}