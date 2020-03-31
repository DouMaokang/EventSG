class User {
  String userId;
  String userName;
  String organization;
  String contactNumber;
  String image;
  String email;

  User({this.userId, this.userName, this.organization, this.image,this.contactNumber,this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      organization: json['organization'],
      image: json['image'],
      contactNumber: json['phoneNum'],
      email:json['email']
    );
  }
}