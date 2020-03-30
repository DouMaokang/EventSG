import 'package:flutter/material.dart';

class FeedbackTopBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

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
