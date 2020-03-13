import 'dart:async';
void main() {
//
// Initialize a "Single-Subscription" Stream controller
//
  final StreamController ctrl = StreamController();
//
// Initialize a single listener which simply prints the data
// as soon as it receives it
//
  final StreamSubscription subscription = ctrl.stream.listen((data) => print('$data'));
//
// We here add the data that will flow inside the stream
//
  ctrl.sink.add('my name');
  ctrl.sink.add(1234);
  ctrl.sink.add({'a': 'element A', 'b': 'element B'});
  ctrl.sink.add(123.45);
//
// We release the StreamController
//
  ctrl.close();
}