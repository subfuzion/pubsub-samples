import 'dart:io';
import 'package:googleapis/pubsub/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

void main() async {
  final accountCredentials = ServiceAccountCredentials.fromJson(r'''
  {
    "type": "service_account",
    "private_key_id": "",
    "private_key": "",
    "client_email": "",
    "client_id": ""
  }
  ''');
  const scopes = [
    PubsubApi.cloudPlatformScope,
  ];

  final client = await clientViaServiceAccount(accountCredentials, scopes);
  //final client = await clientViaApplicationDefaultCredentials(scopes: scopes);
  //final client = await clientViaApplicationDefaultCredentials();
  final pubsub = PubsubApi(client);

  print('--> get topics list');
  final list = await pubsub.projects.topics.list('tonypujals-dart-sample-150');

  print('--> topics');
  if (list.topics == null || list.topics.length == 0) {
    print('error: expected topics');
    exit(1);
  }

  // final topics = list.topics.map((t) => t.name).join(',');
  // print(topics);

  for (var t in list.topics) {
    print('topic: ${t.name}');
  }
}
