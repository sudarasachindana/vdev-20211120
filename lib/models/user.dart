class User {
  String name;

  User({this.name});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        name: responseData['name'],
    );
  }
}
