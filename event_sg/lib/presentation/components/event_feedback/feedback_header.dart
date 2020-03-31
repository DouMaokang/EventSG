import 'package:flutter/material.dart';
import 'package:event_sg/models/models.dart';

class FeedbackHeader extends StatelessWidget {
  final Event event;

  FeedbackHeader({@required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          // child 1 head image ----------------------------------------------------------------
          DecoratedBox(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(event.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 200,
                ),
              )
          ),
          SizedBox(height: 16,),
          // child 2 --event headline-------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              child: Text(
                event.title,
                textAlign: TextAlign.left,
                style: TextStyle(

                    fontSize: 38,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ]
    );
  }
}