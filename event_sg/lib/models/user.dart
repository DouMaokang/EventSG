class User {
  String userId;
  String userName;
  String firstName;
  String lastName;
  String email;
  String birthday;
  int phoneNum;
  String occupation;
  String organization;
  String image;

  User({this.userId, this.userName, this.firstName, this.lastName, this.email,
    this.birthday, this.phoneNum, this.occupation, this.organization, this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['userId'],
        userName: json['userName'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        birthday: json['birthday'],
        phoneNum: json['phoneNum'],
        occupation: json['occupation'],
        organization: json['organization'],
        image:json['image']
    );
  }
}