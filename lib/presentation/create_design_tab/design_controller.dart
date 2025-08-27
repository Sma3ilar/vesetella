import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:pg_web/repositories/design_repository.dart';
import 'package:pg_web/core/extensions/translation_extension.dart';
import 'package:pg_web/core/constants/tr_keys.dart';
import 'package:pg_web/presentation/widgets/snack_bar.dart';

class DesignController extends GetxController {
  final DesignRepository designRepository;

  DesignController({required this.designRepository});

  // --- State Management ---
  final RxInt currentStep = 1.obs;
  final RxBool isLoading = false.obs;

  // --- Step 1: Dropdown Values ---
  final List<String> designOptions = ['Top', 'Dress', 'Pants', 'Jacket'];
  final List<String> fabricOptions = ['Cotton', 'Denim', 'Silk', 'Wool'];
  final List<String> colorOptions = ['Red', 'Blue', 'Green', 'Black', 'White'];
  final List<String> sizeOptions = ['S', 'M', 'L', 'XL'];
  final List<String> collarOptions = ['Round', 'V-Neck', 'Polo', 'Mandarin'];
  final List<String> sleeveOptions = ['Short', 'Long', '3/4', 'Sleeveless'];

  // --- Selected Values ---
  final RxnString selectedDesign = RxnString();
  final RxnString selectedFabric = RxnString();
  final RxnString selectedColor = RxnString();
  final RxnString selectedSize = RxnString();
  final RxnString selectedCollar = RxnString();
  final RxnString selectedSleeve = RxnString();

  // --- Step 4: Text Field Controllers ---
  late TextEditingController numPatternsController;
  late TextEditingController widthController;
  late TextEditingController heightController;

  @override
  void onInit() {
    super.onInit();
    // Initialize controllers
    numPatternsController = TextEditingController();
    widthController = TextEditingController();
    heightController = TextEditingController();
  }

  @override
  void onClose() {
    numPatternsController.dispose();
    widthController.dispose();
    heightController.dispose();
    super.onClose();
  }

  // --- Navigation Logic ---
  void goToNextStep() {
    if (currentStep.value < 5) {
      currentStep.value++;
    }
  }

  void goToPreviousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  void resetProcess() {
    currentStep.value = 1;
    selectedDesign.value = null;
    selectedFabric.value = null;
    selectedColor.value = null;
    selectedSize.value = null;
    selectedCollar.value = null;
    selectedSleeve.value = null;
    numPatternsController.clear();
    widthController.clear();
    heightController.clear();
  }

  /// Validates the form data for step 1
  bool validateStep1() {
    return selectedDesign.value != null &&
        selectedFabric.value != null &&
        selectedColor.value != null &&
        selectedSize.value != null &&
        selectedCollar.value != null &&
        selectedSleeve.value != null;
  }

  /// Validates the form data for step 4
  bool validateStep4() {
    return numPatternsController.text.isNotEmpty &&
        widthController.text.isNotEmpty &&
        heightController.text.isNotEmpty;
  }

  /// Shows the confirmation dialog before generating.
  void showConfirmationDialog() {
    // Simple validation
    if (!validateStep1()) {
      Get.snackbar(
        'Incomplete',
        'Please fill all dropdowns before proceeding.',
      );
      return;
    }

    Get.dialog(const GenerationConfirmationDialog(), barrierDismissible: false);
  }

  /// Triggers the API call and moves to the next step on success.
  Future<void> generateDesign() async {
    // 1. Close the dialog
    Get.back();

    // 2. Set loading state
    isLoading.value = true;

    try {
      // 3. Create form data for API request
      final formData = FormData.fromMap({
        'design_type': selectedDesign.value,
        'fabric_type': selectedFabric.value,
        'color': selectedColor.value,
        'size': selectedSize.value,
        'collar_type': selectedCollar.value,
        'sleeve_type': selectedSleeve.value,
      });

      // 4. Call the repository to create the design
      final result = await designRepository.createDesign(formData);

      // 5. Handle the result
      result.when(
        success: (_) {
          // On success, move to the next step
          showMessage(TrKeys.designCreatedSuccessfully.trn, true);
          goToNextStep();
        },
        failure: (error) {
          // On failure, show error message
          showMessage(error.message, false);
        },
      );
    } catch (e) {
      // Handle unexpected errors
      showMessage(TrKeys.unexpectedError.trn, false);
    } finally {
      // Reset loading state
      isLoading.value = false;
    }
  }

  /// Submits the final design with measurements
  Future<void> submitFinalDesign() async {
    // Validate measurements
    if (!validateStep4()) {
      showMessage('Please enter all measurements', false);
      return;
    }

    isLoading.value = true;

    try {
      // Create form data with all design information
      final formData = FormData.fromMap({
        'design_type': selectedDesign.value,
        'fabric_type': selectedFabric.value,
        'color': selectedColor.value,
        'size': selectedSize.value,
        'collar_type': selectedCollar.value,
        'sleeve_type': selectedSleeve.value,
        'num_patterns': numPatternsController.text,
        'width': widthController.text,
        'height': heightController.text,
      });

      // Call the repository to create the design
      final result = await designRepository.createDesign(formData);

      // Handle the result
      result.when(
        success: (_) {
          showMessage('Design saved successfully!', true);
          goToNextStep(); // Move to the final step
        },
        failure: (error) {
          showMessage(error.message, false);
        },
      );
    } catch (e) {
      showMessage('An unexpected error occurred', false);
    } finally {
      isLoading.value = false;
    }
  }
}

// --- Dialog Widget ---
class GenerationConfirmationDialog extends GetView<DesignController> {
  const GenerationConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(30.r),
        decoration: BoxDecoration(
          color: const Color(0xFFEBE8DB),
          borderRadius: BorderRadius.circular(20.r),
          image: const DecorationImage(
            image: AssetImage('assets/images/shapes.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Let Vestella Begin',
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.h),
            // Show selected options
            Text(
              'Design: ${controller.selectedDesign.value}\n'
              'Fabric: ${controller.selectedFabric.value}\n'
              'Color: ${controller.selectedColor.value}\n'
              'Size: ${controller.selectedSize.value}\n'
              'Collar: ${controller.selectedCollar.value}\n'
              'Sleeve: ${controller.selectedSleeve.value}',
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.generateDesign,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF345F56),
                        minimumSize: Size(double.infinity, 60.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Generate',
                        style: TextStyle(fontSize: 20.sp, color: Colors.white),
                      ),
                    ),
            ),
            SizedBox(height: 15.h),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD2CEC1),
                minimumSize: Size(double.infinity, 60.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Back',
                style: TextStyle(fontSize: 20.sp, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
