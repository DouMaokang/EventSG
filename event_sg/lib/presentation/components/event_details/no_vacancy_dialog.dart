import 'package:flutter/material.dart';

class NoVacancyDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 2,
      backgroundColor: Colors.white,

      title: Text(
        'Alert',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Text(
            'This event has no more vacancies.',
        ),
      ),
      actions: [
        FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Ok',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
