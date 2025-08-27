import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pg_web/core/extensions/translation_extension.dart';
import 'package:pg_web/presentation/widgets/snack_bar.dart'; // Your custom snackbar
import 'package:pg_web/core/constants/tr_keys.dart'; // Your translation keys
import 'package:pg_web/models/request/login_request.dart'; // We will create this
import 'package:pg_web/repositories/auth_repository.dart'; // Reusing this from signup
import '../../core/routes/app_router.dart';
import 'login_state.dart'; // We will create this

class LoginController extends GetxController {
  final AuthRepository authRepository;

  LoginController({required this.authRepository});

  // --- State Management ---
  // Using an Rx variable for state to allow UI reactions
  final Rx<LoginState> state = LoginState.initial().obs;

  // --- Text Controllers ---
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // --- Focus Nodes ---
  var emailFocus = FocusNode();
  var passwordFocus = FocusNode();

  // Add this method after the constructor
  @override
  void onInit() {
    super.onInit();
    // Initialize controllers
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void onClose() {
    // Dispose all controllers and focus nodes to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }

  /// Validates all form inputs and returns an error message string if any are invalid.
  String? validateInputs() {
    if (emailController.text.isEmpty) return TrKeys.emailIsRequired.trn;
    if (!GetUtils.isEmail(emailController.text))
      return TrKeys.invalidEmailFormat.trn;
    if (passwordController.text.isEmpty) return TrKeys.passwordIsRequired.trn;
    if (passwordController.text.length < 6)
      return TrKeys.passwordMustBeAtLeast6Characters.trn;

    // Return null if all validations pass
    return null;
  }

  /// Handles the user login process.
  Future<void> login() async {
    // 1. Validate all inputs before proceeding
    String? validationError = validateInputs();
    if (validationError != null) {
      showMessage(
        validationError,
        false,
      ); // Assuming showMessage is your custom snackbar helper
      return;
    }

    // 2. Set state to loading and update the UI
    state.value = LoginState.loading();

    try {
      // 3. Create the request object from controller values
      final request = LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      );

      // 4. Call the repository to perform the login
      final result = await authRepository.login(
        username: emailController.text,
        password: passwordController.text,
      ); // We'll add this method to AuthRepository

      // 5. Handle the success or failure result
      result.when(
        success: (_) {
          state.value = LoginState.success();
          showMessage(TrKeys.loggedInSuccessfully.trn, true);
          // On success, navigate to the home screen, clearing the navigation stack
          Get.offAllNamed(AppRoutes.home);
        },
        failure: (error) {
          state.value = LoginState.error(message: error.message);
          showMessage(
            error.message,
            false,
          ); // Show the error message from the repository
        },
      );
    } catch (e) {
      // Handle any unexpected errors during the process
      state.value = LoginState.error(message: e.toString());
      showMessage(TrKeys.unexpectedError.trn, false);
    }
  }

  // Method to navigate to the signup screen
  void navigateToSignup() {
    Get.toNamed(AppRoutes.signup); // Replace with your actual signup route
  }
}
