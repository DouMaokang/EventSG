class User {
  String userId;
  String userName;
  String organization;
  String image;

  User({this.userId, this.userName, this.organization, this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      organization: json['organization'],
      image: json['image'],
    );
  }
}