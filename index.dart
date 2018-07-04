import 'dart:io';

main() {

  new Server(80);

}

class Server {

  HttpServer server;

  /**
   * @contructor
   * Start bind of the Http Server
   */
  Server(port) {

    this.start(port);

  }

  void start(int port) async {

    server = await HttpServer.bind(InternetAddress.ANY_IP_V4, port);

    await for (var request in server) {

      if(request.method == 'GET') this.handleRequest(request);
      else {
        request.response
          ..statusCode = HttpStatus.METHOD_NOT_ALLOWED
          ..close();
      }

    }
  }

  /**
   * Handling the request with the GET http method
   */
  void handleRequest(HttpRequest request) {

    HttpResponse response = request.response;
    Uri          uri      = request.uri;

    if(uri.hasQuery) {
      /**
       * Get query here
       */

      this.fileSystem(uri);

    }

    response.close();

  }

  /**
   * File system for data storage
   */
  void fileSystem(Uri uri) {

    // Creating or obtaining a file
    var file = new File('${uri.queryParameters['mac']}.log');

    // Accessing write object
    var sink = file.openWrite(mode: FileMode.APPEND);
    String msg = '=> Adress: ${uri.queryParameters['addr']} - SIP Port: ${uri.queryParameters['port']}\n';

    // Inserting String for the file
    sink.write(msg);

    sink.close();

  }

}
