import 'dart:io';

import 'package:io/io.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

// Make server reachable on any IP address on the host.
const _hostaddr = '0.0.0.0';

void main(List<String> args) async {
  print('Starting server');

  // 8080 is the port used by Cloud Run but always check PORT anyway.
  var portStr = Platform.environment['PORT'] ?? '8080';
  var port = int.tryParse(portStr);

  if (port == null) {
    print('Could not parse port value "$portStr" into a number.');
    exitCode = ExitCode.config.code;
    return;
  }

  handleSignals();

  var handler = const Pipeline().addHandler(_handleRequest);
  var server = await serve(handler, _hostaddr, port);

  print('Serving at http://${server.address.host}:${server.port}');
}

// Handle signals to ensure process exits promptly.
void handleSignals() {
  // Standard signal to terminate.
  ProcessSignal.sigterm.watch().listen((signal) {
    exit(0);
  });
  // Signal triggered by Ctrl-C in a terminal.
  ProcessSignal.sigint.watch().listen((signal) {
    exit(0);
  });
}

// Handle any HTTP request.
Response _handleRequest(Request request) =>
    Response.ok('Request for "${request.url}"');
