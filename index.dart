import 'dart:io';

main() async {

  var server = await HttpServer.bind(InternetAddress.ANY_IP_V4, 80);
  print("Serving at ${server.address.host}:${server.port}");

  await for (var request in server) {
    var response = request.response;

    if(request.method == 'GET') {

      if(request.uri.hasQuery) print('Address: ${request.uri.queryParameters['addr']} Port: ${request.uri.queryParameters['port']}');

      response
        ..headers.contentType = new ContentType("text", "plain", charset: "utf-8")
        ..write('Hello, world!\n');


    } else response.statusCode = HttpStatus.METHOD_NOT_ALLOWED;

    response.close();

  }
}
