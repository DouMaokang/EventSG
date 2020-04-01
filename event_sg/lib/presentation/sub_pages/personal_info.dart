import 'package:flutter/material.dart';
import 'package:event_sg/repositories/repositories.dart';
import 'package:event_sg/api_clients/api_clients.dart';
import 'package:event_sg/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:event_sg/globals/login.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String userId = Login().getUserId();
//  String userId = "d3980cd7-48c5-42a5-8353-02a70c51af45";
  final UserRepository userRepository = UserRepository(
      userApiClient: UserApiClient(httpClient: http.Client())
  );

  Future<User> userInfo;
  Future<List<String>> categories;
  String categoriesString = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfo = userRepository.getUserById(userId);
    categories = userRepository.getInterestedCategories(userId);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: AppBar(
          title: Text(
            "Personal Information",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
      body: FutureBuilder<User>(
        future: userInfo,
        builder: (context, snapshot){
          if(snapshot.hasData)
            {
            return SafeArea(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(snapshot.data.image),
                          )]),
                      SizedBox(height: 10),

                      SizedBox(
                        height: 20.0,
                        width: 200,
                        child: Divider(
                          color: Colors.teal[100],
                        ),
                      ),
                      Card(
                          color: Colors.white,
                          margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.account_circle,
                              color: Colors.teal[900],
                              size: 40,
                            ),
                            subtitle: Text(snapshot.data.userName,
                              style:
                              TextStyle(color: Colors.black, fontSize: 18.0),
                            ),
                            title: Text("Username:", style: TextStyle(fontSize: 15),),
                          )),
                      Card(
                          color: Colors.white,
                          margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.account_circle,
                              color: Colors.teal[900],
                              size: 40,
                            ),
                            subtitle: Text(snapshot.data.firstName+' '+ snapshot.data.lastName,
                              style:
                              TextStyle(color: Colors.black, fontSize: 18.0),
                            ),
                            title: Text("Name:", style: TextStyle(fontSize: 15),),
                          )),
                      Card(
                          color: Colors.white,
                          margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.mail,
                              color: Colors.teal[900],
                              size: 40,
                            ),
                            subtitle: Text(snapshot.data.email,
                              style:
                              TextStyle(color: Colors.black, fontSize: 18.0),
                            ),
                            title: Text("Email:", style: TextStyle(fontSize: 15),),
                          )),
                      Card(
                          color: Colors.white,
                          margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.cake,
                              color: Colors.teal[900],
                              size: 40,
                            ),
                            subtitle: Text(snapshot.data.birthday,
                              style:
                              TextStyle(color: Colors.black, fontSize: 18.0),
                            ),
                            title: Text("Birthday:", style: TextStyle(fontSize: 15),),
                          )),
                      Card(
                          color: Colors.white,
                          margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Colors.teal[900],
                              size: 40,
                            ),
                            subtitle: Text(
                              snapshot.data.phoneNum.toString(),
                              style:
                              TextStyle(color: Colors.black, fontSize: 18.0),
                            ),
                            title: Text("Phone number", style: TextStyle(fontSize: 15)),
                          )),
                      Card(
                          color: Colors.white,
                          margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.work,
                              color: Colors.teal[900],
                              size: 40,
                            ),
                            subtitle: Text(
                              snapshot.data.occupation,
                              style:
                              TextStyle(color: Colors.black, fontSize: 18.0),
                            ),
                            title: Text("Occupation", style: TextStyle(fontSize: 15)),
                          )),
                      Card(
                          color: Colors.white,
                          margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.location_city,
                              color: Colors.teal[900],
                              size: 40,
                            ),
                            subtitle: Text(
                              snapshot.data.organization,
                              style:
                              TextStyle(color: Colors.black, fontSize: 18.0),
                            ),
                            title: Text("Organization", style: TextStyle(fontSize: 15),),
                          )),
                      Card(
                          color: Colors.white,
                          margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.favorite,
                              color: Colors.teal[900],
                              size: 40,
                            ),
                            subtitle: _getCategories(),
                            title: Text("Interested Categories", style: TextStyle(fontSize: 15),),
                          )),
                    ],
                  ),
                )
            )
            ;
            }
          else if(snapshot.hasError) {
            return Text("Error");
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }

  Widget _getCategories(){
    return FutureBuilder<List<String>>(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (var i = 0; i < snapshot.data.length; i++){
            categoriesString+=snapshot.data[i]+'; ';
          }
          return  Text(
            categoriesString,
            style:
            TextStyle(color: Colors.black, fontSize: 18.0),
          );
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
