import 'package:flutter/material.dart';

class EventFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Center(
        child: Column(
          children: <Widget>[
            Text("@All Rights Reserved", style: TextStyle(fontWeight: FontWeight.w200),),
          ],
        ),
      ),
    )
    ;
  }
}
