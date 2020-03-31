class User {
  String userId;
  String userName;
  String organization;
  int phoneNumber;
  String image;
  String email;

  User({this.userId, this.userName, this.organization, this.image,this.phoneNumber,this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      organization: json['organization'],
      image: json['image'],
      phoneNumber: json['phoneNum'],
      email:json['email']
    );
  }
}