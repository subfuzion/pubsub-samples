import 'dart:io';
import 'package:googleapis/pubsub/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

void main() async {
  const scopes = [
    PubsubApi.cloudPlatformScope,
    PubsubApi.pubsubScope,
  ];

  final client = await clientViaApplicationDefaultCredentials(scopes: scopes);

  // basically, calling close() doesn't make any difference
  print('closing...');
  final stopwatch = Stopwatch()..start();
  client.close();
  print('elapsed: ${stopwatch.elapsed}');
  print('closed');
}
