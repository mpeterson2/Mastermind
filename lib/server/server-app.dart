part of ServerApp;

class MasterMindServerApp {
  
  String pathToFiles;
  
  MasterMindServerApp({int port: 9000, bool useDart: false}) {
    
    if(useDart) {
      pathToFiles = "web";
    }
    else {
      pathToFiles = "build/web";
    }
    
    print("Starting server on port $port");
    HttpServer.bind("localhost", port)
      .then((HttpServer server) {
      Router router = new Router(server)
        ..serve("/guess").listen(_guessCode)
        ..defaultStream.listen(_serveFile);
    });
  }
  
  void _serveFile(HttpRequest request) {
    String uri = request.uri.path;
    if(uri == "/")
      uri = "/index.html";
    
    File file = new File(pathToFiles + uri);
    print(file.absolute);
    
    file.exists().then((bool found) {
      if(found) {
        List mimeType = getMimeType(uri.substring(uri.lastIndexOf(".") + 1)).split("/");
        request.response.headers.contentType = new ContentType(mimeType[0], mimeType[1]);
        file.openRead().pipe(request.response);
      }
      
      else {
        request.response.headers.contentType = new ContentType("text", "plain");
        request.response.write("404 - File not Found.");
        request.response.close();
      }
    });
  }
  
  void _guessCode(HttpRequest request) {
    String codeStr = request.uri.queryParameters["code"].trim();
    
    
    Code code = new Code.fromStr(codeStr);
    Mastermind mm = new Mastermind(code);
    
    Map data = new Map();
    data["answer"] = mm.answer.digits;
    data["guesses"] = mm.guesses.map((Code c) => c.digits).toList();
    data["closes"] = mm.matchCloses;
    data["corrects"] = mm.matchCorrects;
    
    String Jsondata = JSON.encode(data);
    
    request.response.write(Jsondata);
    request.response.close();
  }
}