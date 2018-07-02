import 'dart:io';

main() async {

  var server = await HttpServer.bind(InternetAddress.ANY_IP_V4, 8080);
  print("Serving at ${server.address.host}:${server.port}");

  await for (var request in server) {
    var response = request.response,
        uri      = request.uri;

    if(request.method == 'GET') {

      if(uri.hasQuery) {

        if(uri.queryParameters['mac'] != null) {

          var file = new File('${uri.queryParameters['mac']}.log');
          var sink = file.openWrite(mode: FileMode.APPEND);

          var msg = '[ MAC: ${uri.queryParameters['mac']} |';
          msg += ' Date: ${new DateTime.now()} |';
          msg += uri.queryParameters['addr'] == null ? '' : ' Address: ${uri.queryParameters['addr']} |';
          msg += uri.queryParameters['port'] == null ? '' : ' SIP Port${uri.queryParameters['port']}';
          msg += ' ]\n';

          sink.write(msg);

          sink.close();
        }

      }


    } else response.statusCode = HttpStatus.METHOD_NOT_ALLOWED;

    response.close();

  }
}
