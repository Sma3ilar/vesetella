import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pg_web/presentation/widgets/snack_bar.dart'; // Your custom snackbar
import 'package:pg_web/core/constants/tr_keys.dart'; // Your translation keys
import 'package:pg_web/models/request/signup_request.dart';
import 'package:pg_web/repositories/auth_repository.dart';
import '../../core/constants/app_constants.dart';
import '../../core/helpers/local_storage.dart' show LocalStorage;
import '../../core/routes/app_router.dart';
import 'signup_state.dart';

class SignupController extends GetxController {
  final AuthRepository authRepository;

  SignupController({required this.authRepository});

  // --- State Management ---
  // Initialize with Rx<SignupState> instead of specifying a concrete type
  final state = Rx<SignupState>(const SignupInitial());

  // --- Text Controllers ---
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  // --- Focus Nodes ---
  var fullNameFocus = FocusNode();
  var emailFocus = FocusNode();
  var passwordFocus = FocusNode();
  var confirmPasswordFocus = FocusNode();

  var formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    // Dispose all controllers and focus nodes to prevent memory leaks
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    fullNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
  }

  /// Validates all form inputs and returns an error message string if any are invalid.
  String? validateInputs() {
    if (fullNameController.text.isEmpty) return TrKeys.fullNameIsRequired;
    if (emailController.text.isEmpty) return TrKeys.emailIsRequired;
    if (!GetUtils.isEmail(emailController.text))
      return TrKeys.invalidEmailFormat;
    if (passwordController.text.isEmpty) return TrKeys.passwordIsRequired;
    if (passwordController.text.length < 6)
      return TrKeys.passwordMustBeAtLeast6Characters;
    if (confirmPasswordController.text != passwordController.text)
      return TrKeys.passwordsDoNotMatch;

    // Return null if all validations pass
    return null;
  }

  /// Handles the user registration process.
  Future<void> signup() async {
    // 1. Validate all inputs before proceeding
    String? validationError = validateInputs();
    if (validationError != null) {
      showMessage(validationError, false);
      return;
    }

    // 2. Set state to loading and update the UI
    state.value = const SignupLoading();

    try {
      // 3. Create the request object from controller values
      final request = SignupRequest(
        name: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );

      // 4. Call the repository to perform the signup
      final result = await authRepository.register(request);

      // 5. Handle the success or failure result
      result.when(
        success: (data) async {
          if (data != null) {
            // Save user data and token in cache
            if (data.data != null) {
              await LocalStorage.instance.setUserData(data.data!);
            }
            await LocalStorage.instance.setToken(data.accessToken);
            await LocalStorage.instance.setAuth(true);
          }

          // Clear form fields
          fullNameController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();

          state.value = const SignupSuccess();
          showMessage(TrKeys.registeredSuccessfully, true);
          // On success, navigate to the home screen, clearing the navigation stack
          Get.offAllNamed(AppRoutes.mainLayout);
        },
        failure: (error) {
          state.value = SignupError(message: error.message);
          showMessage(error.message, false);
        },
      );
    } catch (e) {
      // Handle any unexpected errors during the process
      state.value = SignupError(message: e.toString());
      showMessage(TrKeys.unexpectedError, false);
    } finally {
      // 6. Update the UI one last time to reflect the final state
      update();
    }
  }

  void navigateToLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  // Add this method after the constructor
  @override
  void onInit() {
    super.onInit();
    // Initialize controllers
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    fullNameFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();

    formKey = GlobalKey<FormState>();
  }
}
