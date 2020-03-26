import 'package:flutter/material.dart';

class EventHeader extends StatelessWidget {
  final String url;
  final String eventName;

  EventHeader({this.url, @required this.eventName});

  @override
  Widget build(BuildContext context) {


    return Column(
      children: <Widget>[
        DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 10.0, // has the effect of softening the shadow
                    spreadRadius: 5.0, // has the effect of extending the shadow
                    offset: Offset(
                      5.0, // horizontal, move right 10
                      2.0, // vertical, move down 10
                    ),
                  )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(this.url),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 200,
              ),
            )
        ),
        SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: double.infinity,
            child: Text(
              this.eventName,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ],
    );
  }
}
