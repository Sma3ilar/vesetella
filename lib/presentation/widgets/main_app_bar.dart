import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../main_layout/main_layout_controller.dart';

class MainAppBar extends GetView<MainLayoutController>
    implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Text(
            'Vestella',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 40.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF335C54),
            ),
          ),

          // Navigation Tabs - Wrap with Obx to react to state changes
          Obx(() => _buildNavTabs(controller.activeTabIndex.value)),

          // Logout Button
          TextButton(
            onPressed: controller.logout,
            child: Text(
              'Log out',
              style: TextStyle(
                color: const Color(0xFF923F3B),
                fontSize: 22.sp,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTabs(int activeIndex) {
    final tabs = ['My Account', 'My Designs', 'Start designing', 'Settings'];
    return Row(
      children: List.generate(tabs.length, (index) {
        final isActive = index == activeIndex;
        return InkWell(
          onTap: () => controller.changeTab(index),
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tabs[index],
                  style: TextStyle(
                    color: isActive ? const Color(0xFF4C7770) : Colors.black87,
                    fontSize: 22.sp,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                // AnimatedOpacity adds a nice fading effect for the underline
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isActive ? 1.0 : 0.0,
                  child: Container(
                    height: 2.h,
                    width: 40.w,
                    color: const Color(0xFF4C7770),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}
