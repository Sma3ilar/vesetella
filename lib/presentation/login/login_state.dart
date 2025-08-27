// lib/presentation/login/login_state.dart

import 'package:flutter/foundation.dart';

@immutable
abstract class LoginState {
  const LoginState();

  // Factory constructors for different states
  factory LoginState.initial() => const LoginInitial();
  factory LoginState.loading() => const LoginLoading();
  factory LoginState.success() => const LoginSuccess();
  factory LoginState.error({required String message}) =>
      LoginError(message: message);

  // Helper getters for easy checking in UI
  bool get isInitial => this is LoginInitial;
  bool get isLoading => this is LoginLoading;
  bool get isSuccess => this is LoginSuccess;
  bool get isError => this is LoginError;
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
}

class LoginError extends LoginState {
  final String message;
  const LoginError({required this.message});
}
