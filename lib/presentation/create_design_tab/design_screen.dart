import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'design_controller.dart';

class DesignScreen extends GetView<DesignController> {
  const DesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // First check if the controller is in a loading state
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      
      return Container(
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
        // Use AnimatedSwitcher for smooth transitions between steps
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: SizedBox(
            // Use a key to tell Flutter that the widget is changing
            key: ValueKey<int>(controller.currentStep.value),
            child: _buildCurrentStep(),
          ),
        ),
      );
    });
  }

  /// Returns the widget for the current step.
  Widget _buildCurrentStep() {
    switch (controller.currentStep.value) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      case 4:
        return _buildStep4();
      case 5:
        return _buildStep5();
      default:
        return const Center(child: Text('Something went wrong'));
    }
  }

  // --- WIDGET FOR EACH STEP ---

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('START YOUR DESIGN', style: _titleTextStyle()),
        SizedBox(height: 50.h),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownColumn(isLeft: true),
              SizedBox(width: 80.w),
              _buildDropdownColumn(isLeft: false),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton.icon(
            onPressed: controller.showConfirmationDialog,
            icon: Text('Next', style: _nextButtonTextStyle()),
            label: Icon(
              Icons.arrow_forward,
              color: const Color(0xFF80455B),
              size: 30.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return _buildCongratsPage(
      title: "CONGRATS\nYOU'RE ALMOST DONE!",
      imageCount: 3,
      buttons: _buildNavigationButtons(
        primaryText: 'Continue and view pattern',
        onPrimary: controller.goToNextStep,
        onBack: controller.goToPreviousStep,
      ),
    );
  }

  Widget _buildStep3() {
    return _buildCongratsPage(
      title: "CONGRATS\nYOU'RE DONE!",
      subtitle: 'Here is your final result:',
      imageCount: 3,
      buttons: _buildNavigationButtons(
        primaryText: 'lets cut',
        secondaryText: 'Save info',
        onPrimary: controller.goToNextStep,
        onSecondary: () {
          /* Add save info logic */
        },
      ),
    );
  }

  // Update Step 4 to submit the final design
  Widget _buildStep4() {
    return Column(
      children: [
        // This step doesn't have a large title in the design
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 550.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CustomTextField(
                    controller: controller.numPatternsController,
                    label: 'Enter the number of patterns',
                    hint: 'Number of patterns',
                  ),
                  _CustomTextField(
                    controller: controller.widthController,
                    label: 'Enter the width',
                    hint: 'Width',
                  ),
                  _CustomTextField(
                    controller: controller.heightController,
                    label: 'Enter the height',
                    hint: 'Height',
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildNavigationButtons(
          primaryText: 'Cut',
          onPrimary: controller.goToNextStep,
          onBack: controller.goToPreviousStep,
        ),
      ],
    );
  }

  Widget _buildStep5() {
    return _buildCongratsPage(
      title: "YOU'RE DONE!",
      imageCount: 1, // Only one image for the final result
      buttons: Center(
        child: SizedBox(
          width: 280.w,
          child: _StyledButton(
            text: 'Save final cut',
            onPressed: controller.resetProcess,
            color: const Color(0xFF4C7770), // Primary color
          ),
        ),
      ),
    );
  }
  // --- REUSABLE HELPER WIDGETS ---

  TextStyle _titleTextStyle() => TextStyle(
    color: const Color(0xFF335C54),
    fontSize: 48.sp,
    fontFamily: 'Outfit',
    fontWeight: FontWeight.w500,
  );

  TextStyle _nextButtonTextStyle() => TextStyle(
    color: const Color(0xFF80455B),
    fontSize: 30.sp,
    fontFamily: 'Outfit',
    fontWeight: FontWeight.w500,
  );

  Widget _buildDropdownColumn({required bool isLeft}) {
    // This helper builds one of the two columns of dropdowns in Step 1
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isLeft
            ? [
                _CustomDropdown(
                  title: 'What would you like to design?',
                  hint: 'Choose Design',
                  value: controller.selectedDesign.value,
                  items: controller.designOptions,
                  onChanged: (val) => controller.selectedDesign.value = val,
                ),
                _CustomDropdown(
                  title: 'Choose the Collar design',
                  hint: 'Collar design',
                ),
                _CustomDropdown(title: 'Sleeve', hint: 'Sleeve'),
              ]
            : [
                _CustomDropdown(
                  title: 'Choose the Fabric',
                  hint: 'Fabric',
                  value: controller.selectedFabric.value,
                  items: controller.fabricOptions,
                  onChanged: (val) => controller.selectedFabric.value = val,
                ),
                _CustomDropdown(title: 'Choose Color', hint: 'Color'),
                _CustomDropdown(title: 'Choose the size', hint: 'size'),
              ],
      ),
    );
  }

  Widget _buildCongratsPage({
    required String title,
    String? subtitle,
    required int imageCount,
    required Widget buttons,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(title, textAlign: TextAlign.center, style: _titleTextStyle()),
            if (subtitle != null) ...[
              SizedBox(height: 20.h),
              Text(
                subtitle,
                style: TextStyle(fontSize: 24.sp, color: Colors.black54),
              ),
            ],
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              imageCount,
              (_) => Image.asset('assets/images/jacket.png', height: 250.h),
            ),
          ),
        ),
        buttons,
      ],
    );
  }

  Widget _buildNavigationButtons({
    required String primaryText,
    String? secondaryText,
    required VoidCallback onPrimary,
    VoidCallback? onSecondary,
    VoidCallback? onBack,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (onBack != null)
          _StyledButton(
            text: 'back',
            onPressed: onBack,
            color: const Color(0xFF923F3B),
          ),
        if (onBack != null || onSecondary != null) SizedBox(width: 20.w),
        if (secondaryText != null && onSecondary != null)
          _StyledButton(
            text: secondaryText,
            onPressed: onSecondary,
            color: const Color(0xFF923F3B),
          ),
        if (onSecondary != null) SizedBox(width: 20.w),
        _StyledButton(
          text: primaryText,
          onPressed: onPrimary,
          color: const Color(0xFF4C7770),
        ),
      ],
    );
  }
}

/// A custom styled button to be reused across the design steps.
class _StyledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const _StyledButton({
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFFF1F3F4),
          fontSize: 22.sp,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// A custom text field for Step 4.
class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const _CustomTextField({
    required this.controller,
    required this.label,
    required this.hint,
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
            style: TextStyle(color: const Color(0xFF7C838A), fontSize: 20.sp),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color(0xFFF0F0F0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A custom dropdown widget to match your design.
class _CustomDropdown extends StatelessWidget {
  final String title;
  final String hint;
  final String? value;
  final List<String>? items;
  final ValueChanged<String?>? onChanged;

  const _CustomDropdown({
    required this.title,
    required this.hint,
    this.value,
    this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF7C838A),
              fontSize: 20.sp,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          DropdownButtonFormField<String>(
            value: value,
            items:
                items?.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList() ??
                [],
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF0F0F0),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
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
