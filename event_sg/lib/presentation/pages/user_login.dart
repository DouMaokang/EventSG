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
                                SizedBox(
                                  width: double.infinity,
                                  child: FlatButton(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    color: Colors.blue,
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<UserLoginBloc>(context)
                                          .add(
                                          UserLoginClicked(
                                              email: emailController.text.toLowerCase(),
                                              password: passwordController
                                                  .text));

                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: FlatButton(
                                      color: Colors.white,
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => RegistrationPage()),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (state is UserLoginProcessing) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is UserLoginValidated) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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

                            SizedBox(
                              height: 84,
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: SizedBox(
                                width: double.infinity,
                                child: FlatButton(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  color: Colors.blue,
                                  child: Text(
                                    "Enter Home",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => App()),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );


                    } else {

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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

                            SizedBox(
                              height: 84,

                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.error_outline, size: 46,),
                                  SizedBox(height: 24,),
                                  Text(
                                    "Sorry, this account is invalid",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                    ),
                                  ),
                                  SizedBox(height: 24,),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: SizedBox(
                                width: double.infinity,
                                child: FlatButton(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  color: Colors.pink[200],
                                  child: Text(
                                    "Back to Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => UserLogin()),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );

                    }
                  }
                    ),
            )),
      ),
    );
  }
}

