class User {
  String userId;
  String userName;
  String organization;

  User({this.userId, this.userName, this.organization});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['userId'],
        userName: json['userName'],
        organization: json['organization']
    );
  }
}