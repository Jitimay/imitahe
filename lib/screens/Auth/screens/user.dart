class User {
  final int? id;
  final String email;
  final String passwordHash;

  User({this.id, required this.email, required this.passwordHash});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'passwordHash': passwordHash,
    };
  }
}
