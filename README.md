# Set up

### 1) [Create](https://console.cloud.google.com/projectcreate) a new project in the
Google Cloud console.

### 2) Authorize `gcloud` to manage your project resources from your local system.

```text
gcloud auth login
```

### 3) Create a `gcloud` configuration for managing your project locally:

An easy way to keep track of your local configurations is to name them after
your Google Cloud projects.

```text
gcloud config configurations create PROJECT-NAME
```

#### 3.1) Set the default project using the Google Project ID

The project ID is not necessarily the same as the project name. Check the
[dashboard](https://console.cloud.google.com/home/dashboard) in the console, or
enter the following command to confirm:

```text
gcloud projects list
```

Then configure `gcloud`:

```text
gcloud config set project PROJECT-ID
```

### 4) Enable the pubsub API

```text
gcloud services enable pubsub.googleapis.com
```

### 5) Authorize your application code to connect to Google Cloud services:

This is similar to using a service account, but without the risks that come
along with that in a local development environment. This is considered a best
practice because it doesn't require that you download credentials to your
personal machine.

```text
gcloud auth application-default login
```

### 6) Run the demo

```text
cd dart/client-slow-exit
dart pub install
time dart main.dart
```

Output:
```text
$ time dart main.dart
closing client...
client should be closed
elapsed: 0:00:00.001319
Done, should exit now...

real    0m17.080s
user    0m1.281s
sys     0m0.217s

```

This demonstrates an issue with releasing the client in a timely way.

#### 6.1)

Modify `~/.pub-cache/hosted/pub.dartlang.org/googleapis_auth-1.0. 0/lib/src/auth_http_utils.dart`

Line 93: change `bool closeUnderlyingClient = false` to `true`.

```dart
/// Will close the underlying `http.Client` depending on a constructor argument.
class AutoRefreshingClient extends AutoRefreshDelegatingClient {
  final ClientId clientId;
  final String? quotaProject;
  @override
  AccessCredentials credentials;
  late Client authClient;

  AutoRefreshingClient(
    Client client,
    this.clientId,
    this.credentials, {
    bool closeUnderlyingClient = true,
    this.quotaProject,
  })  : assert(credentials.accessToken.type == 'Bearer'),
        assert(credentials.refreshToken != null),
        super(client, closeUnderlyingClient: closeUnderlyingClient) {
    authClient = AuthenticatedClient(
      baseClient,
      credentials,
      quotaProject: quotaProject,
    );
  }
```
Time the app now, app exits immediately.

```text
time dart main.dart
```

Output:
```text
closing client...
client should be closed
elapsed: 0:00:00.006440
Done, should exit now...

real    0m1.120s
user    0m1.243s
sys     0m0.215s
```
