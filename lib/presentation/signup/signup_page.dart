import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'signup_controller.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // We use LayoutBuilder to decide which layout to show based on screen width.
          // A common breakpoint for web is around 800-900 pixels.
          if (constraints.maxWidth > 900) {
            return _buildWideLayout(); // For web and tablets
          } else {
            return _buildNarrowLayout(); // For mobile
          }
        },
      ),
    );
  }

  // --- WIDGETS FOR DIFFERENT LAYOUTS ---

  /// Layout for wide screens (web, tablets).
  Widget _buildWideLayout() {
    return Row(
      children: [
        // Left side: The form (takes up 50% of the width)
        Expanded(flex: 1, child: _buildFormSide()),
        // Right side: The image (takes up the other 50%)
        Expanded(
          flex: 1,
          child: Container(
            height: double.infinity,
            child: Image.asset(
              'assets/images/girl_pic.png', // Make sure you have this image
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  /// Layout for narrow screens (mobile).
  Widget _buildNarrowLayout() {
    // On mobile, we only show the form side to keep it clean.
    return _buildFormSide();
  }

  // --- REUSABLE WIDGETS ---

  /// The main form content, used by both layouts.
  Widget _buildFormSide() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.17, 0.39),
          end: Alignment(0.91, 0.57),
          colors: [Color(0xFFE2E5CA), Color(0xFFFDE2C5)],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500.w,
            ), // Max width for the form
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', height: 60.h),
                  SizedBox(height: 60.h),
                  Text(
                    'Create your Account',
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Form Fields using our custom widget
                  // In the form section
                  _CustomAuthTextField(
                    label: 'Full Name',
                    hint: 'Enter your Full Name',
                    controller: controller.fullNameController,
                    focusNode: controller.fullNameFocus,
                    nextFocusNode: controller.emailFocus,
                    validator: (value) {
                      if (value!.isEmpty) return 'Full name is required';
                      return null;
                    },
                  ),
                  _CustomAuthTextField(
                    label: 'Email',
                    hint: 'Enter your Email',
                    controller: controller.emailController,
                    focusNode: controller.emailFocus,
                    nextFocusNode: controller.passwordFocus,
                    validator: (value) {
                      if (value!.isEmpty) return 'Email is required';
                      if (!GetUtils.isEmail(value))
                        return 'Enter a valid email';
                      return null;
                    },
                  ),
                  _CustomAuthTextField(
                    label: 'Password',
                    hint: 'Enter your Password',
                    isPassword: true,
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocus,
                    nextFocusNode: controller.confirmPasswordFocus,
                    validator: (value) {
                      if (value!.isEmpty) return 'Password is required';
                      if (value.length < 6)
                        return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  _CustomAuthTextField(
                    label: 'Confirm Password',
                    hint: 'Enter your Password',
                    isPassword: true,
                    controller: controller.confirmPasswordController,
                    focusNode: controller.confirmPasswordFocus,
                    onSubmitted: controller.state.value.isLoading ? null : controller.signup,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please confirm your password';
                      if (value != controller.passwordController.text)
                        return 'Passwords do not match';
                      return null;
                    },
                  ),
                  SizedBox(height: 40.h),

                  // Create Account Button
                  SizedBox(
                    width: double.infinity,
                    child: Obx(() => ElevatedButton(
                      onPressed: controller.state.value.isLoading ? null : controller.signup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF345F56),
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: controller.state.value.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Create Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    )),
                  ),
                  SizedBox(height: 20.h),

                  // Login Link
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: const Color(0xFF7C838A),
                          fontSize: 16.sp,
                          fontFamily: 'Outfit',
                        ),
                        children: [
                          const TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Log in',
                            style: const TextStyle(
                              color: Color(0xFF4C7770),
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = controller.navigateToLogin,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A custom text field widget to avoid repeating code.
/// It's good practice to move this to its own file in a `widgets` folder.
class _CustomAuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final VoidCallback? onSubmitted;

  const _CustomAuthTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.validator,
    this.focusNode,
    this.nextFocusNode,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF7C838A),
              fontSize: 18.sp,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller,
            obscureText: isPassword,
            validator: validator,
            focusNode: focusNode,
            onFieldSubmitted: (_) {
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              } else if (onSubmitted != null) {
                onSubmitted!();
              }
            },
            textInputAction: nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 18.sp,
                fontFamily: 'Outfit',
              ),
              filled: true,
              fillColor: const Color(0xFFF9F9F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
