import 'package:flutter/material.dart';
import 'widgets/notification_listview.dart';
import 'widgets/feedback_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Notifications(),
    );
  }
}

