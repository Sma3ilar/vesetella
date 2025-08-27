import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pg_web/models/data/design_item_model.dart';
import 'my_desings_controller.dart';

class MyDesignsScreen extends GetView<MyDesignsController> {
  const MyDesignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This page is hosted inside the MainLayout, so we only need to build its body
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
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Wrap(
            spacing: 40.w, // Horizontal space between cards
            runSpacing: 40.h, // Vertical space between cards
            alignment: WrapAlignment.center,
            children: controller.designs
                .map((design) => _DesignCard(design: design))
                .toList(),
          ),
        );
      }),
    );
  }
}

/// A private widget for the design card, based on your Figma snippet.
/// It's good practice to move this to its own file in a `widgets` folder for reusability.
class _DesignCard extends StatelessWidget {
  final DesignItemModel design;

  const _DesignCard({required this.design});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 530.w,
      padding: EdgeInsets.all(12.r),
      decoration: ShapeDecoration(
        color: const Color(0xFFF0EBE5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x0F000000),
            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side with images
          Container(
            width: 250.w,
            padding: EdgeInsets.all(32.r),
            decoration: ShapeDecoration(
              color: const Color(0xFFF1ECD5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16.r,
              runSpacing: 16.r,
              children: design.imagePaths
                  .map(
                    (path) => Image.asset(
                      path,
                      width: 85.w,
                      height: 85.h,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(width: 38.w),
          // Right side with text details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoText(design.title, isTitle: true),
                SizedBox(height: 8.h),
                _buildInfoText(design.color),
                SizedBox(height: 8.h),
                _buildInfoText(design.number),
                SizedBox(height: 8.h),
                _buildInfoText(design.fabric),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoText(String text, {bool isTitle = false}) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xFF7C838A),
        fontSize: isTitle ? 30.sp : 26.sp,
        fontFamily: 'Outfit',
        fontWeight: isTitle ? FontWeight.w500 : FontWeight.w300,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
