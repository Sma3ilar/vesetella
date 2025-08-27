import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'login_controller.dart';
import 'login_state.dart'; // Import the state

// Assuming _CustomAuthTextField is in a common widgets file
// For this example, I'll include it here again for completeness,
// but in a real app, you'd import it:
// import 'package:pg_web/presentation/widgets/custom_auth_textfield.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive layout based on screen width
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
    // On mobile, we only show the form side.
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 60.h),
                SizedBox(height: 60.h),
                Text(
                  'Login your Account',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 40.h),

                // Form Fields using our custom widget
                _CustomAuthTextField(
                  label: 'Email',
                  hint: 'Enter your Email',
                  controller: controller.emailController,
                  validator: (value) {
                    if (value!.isEmpty) return 'Email is required';
                    if (!GetUtils.isEmail(value)) return 'Enter a valid email';
                    return null;
                  },
                ),
                _CustomAuthTextField(
                  label: 'Password',
                  hint: 'Enter your Password',
                  isPassword: true,
                  controller: controller.passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return 'Password is required';
                    if (value.length < 6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                SizedBox(height: 40.h),

                // Login Button
                Obx(() {
                  // Use Obx to react to changes in controller.state
                  final isLoading = controller.state.value.isLoading;
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : controller.login, // Disable button while loading
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF345F56),
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  );
                }),
                SizedBox(height: 20.h),

                // Signup Link
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
                        const TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Signup',
                          style: const TextStyle(
                            color: Color(0xFF4C7770),
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = controller.navigateToSignup,
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
    );
  }
}

/// A custom text field widget (reused from signup)
/// It's good practice to move this to its own file in a `widgets` folder.
class _CustomAuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  const _CustomAuthTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.validator,
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
