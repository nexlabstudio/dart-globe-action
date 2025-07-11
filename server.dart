import 'dart:io';
import 'dart:convert'; 

void main() async {
  final port = 8080;

  final address = InternetAddress.anyIPv4;

  try {
    // Create an HTTP server and bind it to the specified address and port.
    // The `shared` parameter allows multiple isolates to listen on the same port.
    final server = await HttpServer.bind(address, port, shared: true);
    print('Server listening on http://${server.address.host}:${server.port}');

    await for (HttpRequest request in server) {
      // Handle different request paths if needed.
      // For this simple example, we'll respond to all paths.
      print('Received request for: ${request.method} ${request.uri.path}');

      final HttpResponse response = request.response;

      response.headers.contentType = ContentType.json;

      final Map<String, dynamic> jsonData = {
        'message': 'Hello from Dart simple server!',
        'timestamp': DateTime.now().toIso8601String(),
        'status': 'success',
        'data': {
          'name': 'Dart Server',
          'version': '1.0',
          'language': 'Dart',
        },
      };

      final String jsonString = jsonEncode(jsonData);

      response.write(jsonString);

      await response.close();
    }
  } catch (e) {
    print('Error starting or running server: $e');
  }
}
