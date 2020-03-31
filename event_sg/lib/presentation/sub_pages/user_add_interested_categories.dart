import 'package:event_sg/globals/event_categories.dart';
import 'package:event_sg/globals/urls.dart';
import 'package:event_sg/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:http/http.dart' as http;
import 'package:event_sg/presentation/components/components.dart';
import 'package:event_sg/globals/login.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';


class AddInterestedCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddInterestedCategoryPageState();
}

class _AddInterestedCategoryPageState extends State<AddInterestedCategoryPage> {

  List<String> interestList = EventCategories.eventCategories;
  List<String> selectedItems = List();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose your interest")),
      body: new SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  _buildSelect("Categories", interestList),
                  new Container(
                      margin: EdgeInsets.all(2),
                      child: FlatButton(
                          child: Text('Submit'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            _submit();
                          }))
                ]
            )
        ));
  }

  _buildSelect(String name, List<String> categoryList) {
    return new Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15,),
              textAlign: TextAlign.left),
          MultiSelectChip(
            categoryList,
            onSelectionChanged: (selectedList) {
              setState(() {
                selectedItems = selectedList;
              });
            },
          ),
          new Divider()
        ],
      ),
    );
  }

  void _submit() async {
    print(selectedItems);
    String userId = Login().getUserId();
    String url ='${Urls.apiUrlBase}/user/addCategory/$userId/';


    for (var i = 0; i < selectedItems.length; i++) {
        String updatedUrl = url + selectedItems[i];
        String response = await apiRequest(updatedUrl);
    }
      _showSuccessDialog();

  }


  void _showSuccessDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success"),
          content: new Text("Categories Added!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Done"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> apiRequest(String url) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    // todo - should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }
}
