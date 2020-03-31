import 'package:event_sg/globals/login.dart';
import 'package:event_sg/presentation/pages/home.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isClicked = false;
  bool _isLoginSuccessful = false;

  _checkIsLoginSuccessful(String email, String password) async {
    bool result = await Login().logIn(email: email, password: password);
    setState(() {
      _isLoginSuccessful = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    String _password;
    String _email;

    return Scaffold(
      appBar: AppBar(
        title:
            Align(alignment: Alignment.centerLeft, child: const Text('Login')),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Container(
                    width: double.infinity,
                    child: Image.asset('assets/image/event_sg_icon.png',
                        height: 300, fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                new Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  child: TextFormField(
                    controller: emailController,
                    onSaved: (value) => _email = value,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      Pattern pattern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(value))
                        return 'Invalid email format';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email'),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                new Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (!_isClicked)
                        return null;
                      else
                        return 'Invalid email or password';
                    },
                    onSaved: (value) => _password = value,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Password'),
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
                    onPressed: () {
                      setState(() {
                        _checkIsLoginSuccessful(emailController.text, passwordController.text);
                      });
                      if (_formKey.currentState.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage()));
                      }
                    },
                    color: Colors.blueAccent,
                  ),
                ]),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
      ),
    );
  }
}
