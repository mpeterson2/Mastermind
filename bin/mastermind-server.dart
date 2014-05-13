import "dart:io";
import "package:args/args.dart";
import "package:mastermind/server-app.dart";


void main(List<String> args) {
  ArgParser parser = getParser();
  ArgResults results = parser.parse(args);
  requestHelp(results, parser);
  
  
  new MasterMindServerApp(useDart: results["dart"]);
}

ArgParser getParser() {
  return new ArgParser()
    ..addFlag("dart", abbr: "d", help: "Serve Dart code instead of JavaScript.", defaultsTo: false)
    ..addFlag("help", abbr: "h", help: "Prints usage.", defaultsTo: false, negatable: false);
}

void requestHelp(ArgResults results, ArgParser parser) {
  if(results["help"]) {
    print("Mastermind Server Usage: ");
    print(parser.getUsage());
    exit(0);
  }  
}