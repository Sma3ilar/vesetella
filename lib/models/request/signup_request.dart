// lib/models/request/signup_request.dart

class SignupRequest {
  final String fullName;
  final String email;
  final String password;

  SignupRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });

  // You would typically add a toJson() method here to send to an API
  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'password': password,
  };
}
