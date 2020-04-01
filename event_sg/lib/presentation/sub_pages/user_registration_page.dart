import 'package:event_sg/globals/urls.dart';
import 'package:event_sg/presentation/pages/home.dart';
import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:event_sg/globals/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main(){
  runApp(RegistrationPage());
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  bool postClicked = false;


  Map jsonMap = {
    "userName": "",
    "firstName": "",
    "lastName": "",
    "email": "",
    "password": "",
    "birthday": "",
    "phoneNum": 0,
    "occupation": "",
    "organization": ""
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: true,
      child: Scaffold(
          appBar: PreferredSize(child: AppBar(title: Text("Create Account")),
            preferredSize: Size.fromHeight(44.0),),
          body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                children: <Widget>[
                  userNameInput(),
                  const SizedBox(height: 16.0),
                  Row(children: <Widget>[new Flexible(child: firstNameInput()),
                    new Flexible(child: lastNameInput())]),
                  const SizedBox(height: 16.0),
                  emailInput(),
                  const SizedBox(height: 16.0),
                  passwordInput(),
                  const SizedBox(height: 16.0),
                  birthdayInput(),
                  const SizedBox(height: 16.0),
                  numberInput(),
                  const SizedBox(height: 16.0),
                  occupationInput(),
                  const SizedBox(height: 16.0),
                  organizationInput(),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: _agreedToTOS,
                          onChanged: _setAgreedToTOS,
                        ),
                        GestureDetector(
                          onTap: () => _setAgreedToTOS(!_agreedToTOS),
                          child: const Text(
                            'I agree to the Terms of Services Policy',
                          ),
                        ),
                      ],
                    ),
                  ),

                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    color: Colors.blue,
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      postClicked = true;
                      if (_submittable())
                        _submit();
                    },
                  ),
                  SizedBox(height: 36,)
                ],
              ))),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() async {
    print(jsonMap);
    if (_formKey.currentState.validate()) {
      String url = '${Urls.apiUrlBase}/user/add';
      print(url);
      String response = await apiRequest(url, jsonMap);
      print(response);

      if (response != "")
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
          content: new Text(
              "The Username/Email/Phone number has already been registered."),
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

  void _showSuccessDialog() async {
    String url = "${Urls
        .apiUrlBase}/user/login/${jsonMap["email"]}/${jsonMap["password"]}";
    newAccountLogin(url);
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
//        String userId = jsonDecode(response.body);
//        Login().logIn(jsonMap["email"], jsonMap["password"]);

        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success"),
          content: new Text("Account created. You are now logged in!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AddInterestedCategoryPage()),
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

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }

  Widget userNameInput() {
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Username",
          hintText: "e.g Morgan",
        ),
        textInputAction: TextInputAction.done,
        onChanged: (name) {
          jsonMap["userName"] = name;
        },
        validator: (username) {
          if (postClicked != true && username.length == 0)
            return null;
          Pattern pattern =
              r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(username.trim())) {
            return 'Username should have at least 6 characters and contain \nat least 1 letter & 1 number. ';
          }
          else
            return null;
        }
    );
  }

  Widget firstNameInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "e.g Sarah",
      ),
      textInputAction: TextInputAction.done,
      onChanged: (name) => jsonMap["firstName"] = name,
    );
  }

  Widget lastNameInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "e.g Tan",
      ),
      textInputAction: TextInputAction.done,
      onChanged: (name) => jsonMap["lastName"] = name,
    );
  }

  Widget occupationInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Occupation",
        hintText: "e.g Student",
      ),
      textInputAction: TextInputAction.done,
      onChanged: (name) => jsonMap["occupation"] = name,
    );
  }

  Widget organizationInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Organization",
        hintText: "e.g NTU",
      ),
      textInputAction: TextInputAction.done,
      onChanged: (name) => jsonMap["organization"] = name,
    );
  }

  Widget emailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "e.g abc@gmail.com",
      ),
      textInputAction: TextInputAction.done,
      validator: (email) {
        if (postClicked == false && email.length == 0) {
          return null;
        }
        else {
          if (EmailValidator.validate(email))
            return null;
          else
            return "Invalid email address";
        }
      },
      onChanged: (name) => jsonMap["email"] = name,
    );
  }

  Widget passwordInput() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: Icon(Icons.lock),
      ),
      textInputAction: TextInputAction.done,
      validator: (password) {
        if (postClicked != true && password.length == 0)
          return null;
        Pattern pattern =
            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(password)) {
          return 'Password should have at least 6 characters and contain \nat least 1 letter & 1 number.';
        }
        else
          return null;
      },
      onChanged: (name) => jsonMap["password"] = name,
    );
  }

  Widget birthdayInput() {
    final format = DateFormat("yyyy-MM-dd");
    return DateTimeField(
        decoration: InputDecoration(
            labelText: 'Select Birthday Date (${format.pattern})'),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        validator: (chosenDate) {
          if (postClicked != true && chosenDate == null)
            return null;
          var now = new DateTime.now();
          if (chosenDate != null) {
            if (chosenDate.isBefore(now) == false) {
              return "Birthday date should be before the current date.";
            }
          }
          return null;
        },
        onChanged: (date) {
          if (date
              .toString()
              .length >= 10)
            jsonMap["birthday"] = date.toString().substring(0, 10);
        });
  }

  Widget numberInput() {
    return TextFormField(
        decoration: new InputDecoration(labelText: "Enter your phone number:"),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly],
        validator: (phoneNum) {
          if (postClicked != true && phoneNum == "")
            return null;
          if (phoneNum
              .trim()
              .length != 8) {
            return "Invalid phone number. There should be 8 digits.";
          }
          return null;
        },
        onChanged: (num) => jsonMap["phoneNum"] = num);
  }

  void newAccountLogin(String url) async {
    final response = await http.get(url);
    String userId = jsonDecode(response.body);
    if (userId.length != Uuid()
        .v4()
        .length) {
      print("wrong password");
    } else {
      print("Login succeeded!");
      Login().logIn(userId);
    }
  }

}

