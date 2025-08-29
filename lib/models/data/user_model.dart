class UserData {
  final String? email;
  final String? password;

  UserData({this.email, this.password});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(email: json['email'], password: json['password']);
  }
  
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password
    };
  }
}

class UserModelData {
  final String id;
  final String name;
  final String email;

  UserModelData({required this.id, required this.name, required this.email});

  factory UserModelData.fromJson(Map<String, dynamic> json) {
    return UserModelData(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}
