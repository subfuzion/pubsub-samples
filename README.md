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
This demonstrates an issue with releasing the client in a timely way.
