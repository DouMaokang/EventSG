import 'package:flutter/material.dart';
import './registration_dialog.dart';

class EventRegistrationBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.lightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),

          ),
          ButtonBar(
              children: [
                FlatButton(
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            RegistrationDialog(
                              eventName: "Alec's awsome event",
                              eventDate: "24 Mar 2020",
                              eventTime: "3:30 PM",));
                  },
                  color: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),

              ]
          )

        ],
      ),
    );
  }
}
