import 'dart:io';

main() async {
  
  var server = await HttpServer.bind(InternetAddress.ANY_IP_V4, 80);
  print("Serving at ${server.address}:${server.port}");

  await for (var request in server) {
    request.response
      ..headers.contentType = new ContentType("text", "plain", charset: "utf-8")
      ..write('Hello, world!')
      ..close();
  }
}
