// lib/models/request/signup_request.dart

class SignupRequest {
  final String name; // Changed from fullName to name
  final String email;
  final String password;
  final String passwordConfirmation; // Added password_confirmation field

  SignupRequest({
    required this.name, // Changed from fullName
    required this.email,
    required this.password,
    required this.passwordConfirmation, // Added parameter
  });

  // Updated toJson method to match API expectations
  Map<String, dynamic> toJson() => {
    'name': name, // Changed from fullName
    'email': email,
    'password': password,
    'password_confirmation': passwordConfirmation, // Added with snake_case format
  };
}
