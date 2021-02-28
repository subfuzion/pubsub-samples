# Running the sample

Demonstrates an issue with the client taking around
15 seconds to exit, whether or not close() is invoked.

```shell
$ dart pub get
$ time dart main.dart
closing...
elapsed: 0:00:00.000903
closed

real    0m16.153s
user    0m1.295s
sys     0m0.227s
```
