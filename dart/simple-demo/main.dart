import 'dart:io';
import 'package:googleapis/pubsub/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';

void main() async {
  final stopwatch = Stopwatch()..start();

  const scopes = [
    PubsubApi.cloudPlatformScope,
    PubsubApi.pubsubScope,
  ];

  final client = await clientViaApplicationDefaultCredentials(scopes: scopes);

  final pubsub = PubsubApi(client);

  print('--> get topics list');
  //final list = await pubsub.projects.topics.list('projects/tonypujals-dart-sample-150');
  final list = await pubsub.projects.topics.list('projects/tonypujals-api-demos');

  // print('--> topics');
  // if (list.topics == null || list.topics.length == 0) {
  //   print('error: expected topics');
  //   exit(1);
  // }
  //
  // final topics = list.topics.map((t) => t.name).join(',');
  // print(topics);
  //
  // for (var t in list.topics) {
  //   print('topic: ${t.name}');
  // }

  print('closing...');
  client.close();
  print('closed');

  print('elapsed: ${stopwatch.elapsed}');
}
