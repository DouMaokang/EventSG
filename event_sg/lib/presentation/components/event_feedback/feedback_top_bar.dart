import 'package:flutter/material.dart';

class FeedbackTopBar extends StatefulWidget {



  @override
  _FeedbackTopBarState createState() => _FeedbackTopBarState();
}


class _FeedbackTopBarState extends State<FeedbackTopBar> {

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Return to previous page',
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        title: Align (
            alignment: Alignment.centerLeft,
            child: const Text('Event Feedbacks')
        ),
      ),
    );
  }
}
