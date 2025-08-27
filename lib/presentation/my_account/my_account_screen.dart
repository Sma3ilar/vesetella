import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'my_account_controller.dart';

class MyAccountScreen extends GetView<MyAccountController> {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This screen is displayed within the MainLayout
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 50.h),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(48),
          topRight: Radius.circular(48),
        ),
        gradient: const LinearGradient(
          begin: Alignment(1.00, 1.00),
          end: Alignment(0.00, 0.00),
          colors: [Color(0xFFFDE2C5), Color(0xFFE2E5CA)],
        ),
        image: DecorationImage(
          image: const AssetImage('assets/images/shapes.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.5),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF335C54)),
          );
        }

        if (controller.user.value == null) {
          return const Center(child: Text('Could not load user profile.'));
        }

        // Once loaded, display the profile card
        return Center(child: _buildProfileCard());
      }),
    );
  }

  Widget _buildProfileCard() {
    final user = controller.user.value!;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 50.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF0EBE5).withOpacity(0.8),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: const Color(0xFF4C7770),
              child: Icon(
                Icons.person_outline,
                size: 60.r,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 32.sp,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w600,
                color: const Color(0xFF335C54),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              user.email,
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: 'Outfit',
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: controller.editProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C7770),
                minimumSize: Size(250.w, 60.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontFamily: 'Outfit',
                ),
              ),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: controller.changePassword,
              child: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Outfit',
                  color: const Color(0xFF923F3B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
