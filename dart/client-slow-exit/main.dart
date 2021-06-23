import 'dart:io';
import 'package:googleapis/pubsub/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';

void main() async {
  const scopes = [
    PubsubApi.cloudPlatformScope,
    PubsubApi.pubsubScope,
  ];

  final client = await clientViaApplicationDefaultCredentials(scopes: scopes, baseClient: Client());

  // basically, calling close() doesn't make any difference
  final stopwatch = Stopwatch()..start();
  print('closing...');
  client.close();
  print('closed');
  print('elapsed: ${stopwatch.elapsed}');
}
