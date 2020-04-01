import 'dart:async';

import 'package:event_sg/blocs/blocs.dart';
import 'package:event_sg/presentation/sub_pages/sub_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool _isClicked = false;
    String _password;
    String _email;

    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocProvider<UserLoginBloc>(
              create: (context) => UserLoginBloc(),
              child: BlocBuilder<UserLoginBloc, UserLoginState>(
                  builder: (context, state) {
                    if (state is UserNotLoggedIn) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Form(
                            key: _formKey,
                            autovalidate: true,
                            child: Column(
                              children: <Widget>[
                                DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.white),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(12, 32, 12, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/app-icon.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        height: 200,
                                      ),
                                    )),
                                new Container(
                                  height: 68,
                                  child: TextFormField(
                                    controller: emailController,
                                    onSaved: (value) => _email = value,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      Pattern pattern =
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                      RegExp regex = new RegExp(pattern);
                                      if (value.length != 0 &&
                                          !regex.hasMatch(value))
                                        return 'Invalid email format';
                                      else
                                        return null;
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        helperText: ' ',
                                        labelText: 'Email'),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                new Container(
                                  height: 68,
                                  child: TextFormField(
                                    controller: passwordController,
                                    // ignore: missing_return
                                    onSaved: (value) => _password = value,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        helperText: ' ',
                                        labelText: 'Password'),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ButtonBar(
                                    mainAxisSize: MainAxisSize.min, children: [
                                  FlatButton(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    // ignore: missing_return
                                    onPressed: () {
                                      BlocProvider.of<UserLoginBloc>(context)
                                          .add(
                                          UserLoginClicked(
                                              email: emailController.text.toLowerCase(),
                                              password: passwordController
                                                  .text));

                                      // ignore: missing_return
//                                  Timer(Duration(seconds: 2), () {
//                                    if (_formKey.currentState.validate()) {
//                                      if (state is UserLoginValidated) {
//                                        Navigator.push(
//                                            context,
//                                            MaterialPageRoute(
//                                                builder: (context) => App()));
//                                      }
//                                    }
//                                  });

                                    },
                                    color: Colors.blueAccent,
                                  ),
                                ]),
                                SizedBox(
                                  height: 60,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      "Don't have an account?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ButtonBar(
                                    mainAxisSize: MainAxisSize.min, children: [
                                  FlatButton(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => RegistrationPage()),
                                      );
                                    },
                                    color: Colors.white,
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (state is UserLoginProcessing) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is UserLoginValidated) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 2,
                        backgroundColor: Colors.white,

                        title: Text(
                          'Confirm Registration',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                          child: ListBody(
                            children: <Widget>[
                              Text('Succeeded'),
                              SizedBox(height: 8,),
                              Text('go to home page'),
                            ],
                          ),
                        ),
                        actions: [
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text(
                              'Confirm',
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            color: Colors.blue,
                            onPressed: () {

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => App()),
                              );
                            },
                          ),
                        ],
                      );

                    } else {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 2,
                        backgroundColor: Colors.white,

                        title: Text(
                          'Confirm Registration',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                          child: ListBody(
                            children: <Widget>[
                              Text('Failed'),
                              SizedBox(height: 8,),
                              Text('go back to login'),
                            ],
                          ),
                        ),
                        actions: [
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text(
                              'Confirm',
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UserLogin()),
                              );
                            },
                          ),
                        ],
                      );

                    }
                  }
                    ),
            )),
      ),
    );
  }
}

