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
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              child: Container(
                decoration: BoxDecoration(
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
