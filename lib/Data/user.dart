class User {
  int? id;
  String? name;
  String? password;
  String? phone;
  String? email;

  User({
    int? id,
    String? name,
    String? password,
    String? phone,
    String? email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'phone': phone,
      'email': email,
    };
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    password = map['password'];
    phone = map['phone'];
    email = map['email'];
  }
}
