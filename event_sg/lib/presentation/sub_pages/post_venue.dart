import 'package:event_sg/globals/login.dart';
import 'package:event_sg/globals/urls.dart';
import 'package:event_sg/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

void main(){
  runApp(VenuePostingPage());
}

class VenuePostingPage extends StatefulWidget {
  const VenuePostingPage({Key key}) : super(key: key);

  @override
  _VenuePostingPageState createState() => _VenuePostingPageState();
}

class _VenuePostingPageState extends State<VenuePostingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool postClicked = false;
  Map jsonMap = {
    "address": "",
    "postalCode": "",
    "ownerId": Login().getUserId(),  // todo get currently logged in user
    "rentalFee": "",
    "area": "",
    "description": "",
    "venueName": ""
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: true,
      child: Scaffold(
          appBar: PreferredSize(child: AppBar(title: Text("Post Venue")), preferredSize: Size.fromHeight(44.0),),
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {FocusScope.of(context).requestFocus(new FocusNode());},
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: <Widget>[
                SizedBox(height: 28,),
                Container(
                  width: double.infinity,
                  child: Text(
                    "  Venue Details",
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 18,),
                venueNameInput(),
                const SizedBox(height: 16.0),
                addressInput(),
                const SizedBox(height: 16.0),
                postalCodeInput(),
                const SizedBox(height: 16.0),
                rentalFeeInput(),
                const SizedBox(height: 16.0),
                areaInput(),
                const SizedBox(height: 16.0),
                descriptionInput(),
                const SizedBox(height: 16.0),

                FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    color: Colors.blue,
                    child: Text(
                      "Post",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      postClicked = true;
                      _submit();
                    },
                ),
                SizedBox(height: 36,)
              ],
            )
          ),
      )
    );
  }

  void _submit() async {
    print(jsonMap);
    if(_formKey.currentState.validate()){
      String url ='${Urls.apiUrlBase}/venue/add';
      String response = await apiRequest(url, jsonMap);
      if(response!="")
        _showDialog();
      else
        _showSuccessDialog();
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("There is an unknown error!."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Try again"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void _showSuccessDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success"),
          content: new Text("Venue created."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();},
            ),
          ],
        );
      },
    );
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  Widget venueNameInput() {
    return TextFormField(
      keyboardType: TextInputType.text ,
      decoration: InputDecoration(
        labelText: "Venue Name",
        hintText: "e.g Hall 14 Function Room",
      ),
      textInputAction: TextInputAction.done,
      onChanged: (name)=> jsonMap["venueName"] = name,
      validator: (venueName){
        if ( postClicked != true && venueName.length == 0 ){
          return null;
        }
        else if (venueName.length == 0){
          return "Venue name cannot be empty.";
        } else {
          return null;
        }

      },
    );
  }

  Widget addressInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text ,
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "e.g 34 Nanyang Crescent",
      ),
      textInputAction: TextInputAction.done,
      onChanged: (name)=> jsonMap["address"] = name,
      validator: (address){
        if ( postClicked != true && address.length == 0 ){
          return null;
        }
        else if (address.length == 0){
          return "Venue address cannot be empty.";
        } else {
          return null;
        }
      },
    );
  }

  Widget postalCodeInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: "Postal Code",
        hintText: "e.g 637634",
      ),
      validator: (postalCode) {
        if(postalCode.trim().length!=6 && postalCode.trim().length>0 && postClicked != true){
          return "Invalid postal code. Length should = 6.";
        }
        else
          return null;

      },
      textInputAction: TextInputAction.done,
      onChanged: (name)=> jsonMap["postalCode"] = int.parse(name),
    );
  }

  Widget rentalFeeInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: "Rental Fee (S\$/hour)",
        hintText: "e.g 200",
      ),
      textInputAction: TextInputAction.done,
      validator: (rentalFee){
        if ( postClicked != true && rentalFee.length == 0 ){
          return null;
        }
        else if (rentalFee.length == 0){
          return "Venue rental fee cannot be empty.";
        } else {
          return null;
        }
      },
      onChanged: (name)=> jsonMap["rentalFee"] = double.parse(name),

    );
  }

  Widget areaInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: "Venue Area (m\u00b2)",
        hintText: "e.g 100",
      ),
      textInputAction: TextInputAction.done,
      onChanged: (name)=> jsonMap["area"] = double.parse(name),
      validator: (area){
        if ( postClicked != true && area.length == 0 ){
          return null;
        }
        else if (area.length == 0){
          return "Venue area cannot be empty.";
        } else {
          return null;
        }
      },
    );
  }

  Widget descriptionInput() {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLines: 7,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
        labelText: "Desciption",
        hintText: "e.g This is the best place for ...",
      ),
      textInputAction: TextInputAction.done,
      onChanged: (name)=> jsonMap["description"] = name,
      validator: (description){
        if ( postClicked != true && description.length == 0 ){
          return null;
        }
        else if (description.length == 0){
          return "Venue description cannot be empty.";
        } else {
          return null;
        }
      },
    );
  }
}