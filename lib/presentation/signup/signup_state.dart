// lib/presentation/signup/signup_state.dart

import 'package:flutter/foundation.dart';

@immutable
abstract class SignupState {
  const SignupState();
  
  // Add this getter to easily check if state is loading
  bool get isLoading => this is SignupLoading;
}

class SignupInitial extends SignupState {
  const SignupInitial();
}

class SignupLoading extends SignupState {
  const SignupLoading();
}

class SignupSuccess extends SignupState {
  const SignupSuccess();
}

class SignupError extends SignupState {
  final String message;
  const SignupError({required this.message});
}
