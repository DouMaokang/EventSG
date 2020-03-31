import 'dart:async';

import 'package:event_sg/blocs/blocs.dart';
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
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      autovalidate: true,
                      child: Column(
                        children: <Widget>[
                          DecoratedBox(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 32, 12, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/app-icon.jpg'),
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
                                if (value.length != 0 && !regex.hasMatch(value))
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
                          ButtonBar(mainAxisSize: MainAxisSize.min, children: [
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
                                BlocProvider.of<UserLoginBloc>(context).add(
                                    UserLoginClicked(
                                        email: emailController.text,
                                        password: passwordController.text));

                                // ignore: missing_return
                                Timer(Duration(seconds: 2), () {
                                  if (_formKey.currentState.validate()) {
                                    if (state is UserLoginValidated) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => App()));
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
                                              Text('xxx'),
                                              SizedBox(height: 8,),
                                              Text('xxx'),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5)),
                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5)),
                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            child: Text(
                                              'Confirm',
                                              style: TextStyle(fontWeight: FontWeight.bold),),
                                            color: Colors.blue,
                                            onPressed: () {

                                            },
                                          ),
                                        ],
                                      );

                                    }
                                  }
                                });

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
                          ButtonBar(mainAxisSize: MainAxisSize.min, children: [
                            FlatButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              onPressed: () {},
                              color: Colors.white,
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            )),
      ),
    );
  }
}
