import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pg_web/presentation/welcome/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the controller using Get.find()
    final controller = Get.find<WelcomeController>();

    return Scaffold(
      body: Opacity(
        opacity: 0.95,
        child: Container(
          width: 1920.w,
          height: 1080.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xFFFDEECD)),
          child: Stack(
            children: [
              // Background with gradient
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 1920.w,
                  height: 1080.h,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(1.00, 1.00),
                      end: const Alignment(0.00, 0.00),
                      colors: [
                        const Color(0xFFFDE2C5),
                        const Color(0xFFE2E5CA),
                      ],
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
              ),

              // Logo at the top center
              Positioned(
                left: 0,
                right: 0,
                top: 100.h,
                child: Center(
                  child: Image.asset('assets/images/logo.png', height: 80.h),
                ),
              ),

              // Main content column
              Positioned(
                left: 307.w,
                top: 338.h,
                child: Container(
                  width: 896.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main title
                      SizedBox(
                        width: 896.w,
                        height: 124.h,
                        child: const Text(
                          'CREATE YOUR PERFECT PATRON IN MINUTES!\n',
                          style: TextStyle(
                            color: Color(0xFF335C54),
                            fontSize: 55,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 36.h),

                      // Subtitle with rich text
                      SizedBox(
                        width: 896.w,
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'GENERATE YOUR OWN DESIGN AND ',
                                style: TextStyle(
                                  color: Color(0xFF923F3B),
                                  fontSize: 49,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'PATRON WITH JUST A FEW CLICKS',
                                style: TextStyle(
                                  color: Color(0xFF923F3B),
                                  fontSize: 49,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 80.h),

                      // Get Started button
                      ElevatedButton(
                        onPressed: controller.navigateToNextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF335C54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 24.h,
                          ),
                        ),
                        child: Text(
                          'GET STARTED >',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3shirts image on the right side
              Positioned(
                right: 100.w,
                bottom: 100.h,
                child: Image.asset('assets/images/3shirts.png', width: 600.w),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
