import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:pg_web/repositories/design_repository.dart';
import 'package:pg_web/core/constants/tr_keys.dart';
import 'package:pg_web/presentation/widgets/snack_bar.dart';

import '../main_layout/main_layout_controller.dart';

class DesignController extends GetxController {
  final DesignRepository designRepository;

  DesignController({required this.designRepository});

  // --- State Management ---
  final RxInt currentStep = 1.obs;
  final RxBool isLoading = false.obs;

  // Track if design has been generated
  final RxBool designGenerated = false.obs;
  final RxBool designFinalized = false.obs;

  // --- Step 1: Dropdown Values ---
  // Question 1 – Design type (shown but NOT sent to backend)
  final List<String> designOptions = ['Blouse'];

  // Question 2 – Fabric (only Cotton selectable)
  final List<String> fabricOptions = ['Cotton'];

  // Question 3 – Sleeve type
  final List<String> sleeveOptions = ['Sleeves', 'Half Sleeves', 'Sleeveless'];

  // Question 4 – Collar type
  final List<String> collarOptions = ['Round', 'Vneck'];

  // Question 5 – Color (basic named colours)
  final List<String> colorOptions = [
    'Red',
    'Yellow',
    'Green',
    'Blue',
    'Purple',
    'Black',
    'White',
    'Brown',
    'Grey',
    'Orange',
    'Pink',
  ];

  // Question 6 – Size 38‒46
  final List<String> sizeOptions = [for (var i = 38; i <= 46; i) i.toString()];

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

  // --- Simplified Navigation Logic ---
  void goToNextStep() {
    if (currentStep.value < 5) {
      currentStep.value;
    }
  }

  void goToPreviousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  // Direct navigation to specific step
  void goToStep(int step) {
    if (step >= 1 && step <= 5) {
      currentStep.value = step;
    }
  }

  void resetProcess() {
    currentStep.value = 1;
    designGenerated.value = false;
    designFinalized.value = false;
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
    // Design is fixed; only ensure the selectable dropdowns are chosen.
    return selectedFabric.value != null &&
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
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.dialog(const GenerationConfirmationDialog(), barrierDismissible: false);
  }

  /// Step 1: Triggers the API call and moves to the next step on success.
  Future<void> generateDesign() async {
    // 1. Close the dialog
    Get.back();

    // 2. Set loading state
    isLoading.value = true;

    try {
      // Add a small delay to ensure the loading state is visible
      await Future.delayed(const Duration(milliseconds: 300));

      // 4. Call the design repository to create the design
      final result = await designRepository.createDesign(
        sleeveType: selectedSleeve.value!,
        collarType: selectedCollar.value!,
        color: selectedColor.value!,
        fabricType: selectedFabric.value!,
        size: selectedSize.value!,
      );

      // 5. Handle the result
      result.when(
        success: (_) {
          // On success, mark design as generated and move to the next step
          designGenerated.value = true;
          showMessage('Design created successfully!', true);
          goToStep(2); // Directly go to step 2
        },
        failure: (error) {
          // On failure, show error message
          showMessage(error.message, false);
        },
      );
    } catch (e) {
      // Handle unexpected errors
      showMessage(TrKeys.unexpectedError, false);
    } finally {
      // Reset loading state
      isLoading.value = false;
    }
  }

  // Step 2: fetch design using designRepository.fetchDesignData
  Future<void> fetchDesignResult() async {
    isLoading.value = true;
    try {
      final result = await designRepository.fetchDesignData(
        designId: int.parse(selectedDesign.value!),
      );
      result.when(
        success: (design) {
          // On success, mark design as generated and move to the next step
          designGenerated.value = true;
          showMessage('Design fetched successfully!', true);
          goToStep(3); // Changed: Navigate to step 3 instead of step 2
        },
        failure: (error) {
          // On failure, show error message
          showMessage(error.message, false);
        },
      );
    } catch (e) {
      showMessage('An unexpected error occurred', false);
    } finally {
      isLoading.value = false;
    }
  }

  /// Step 4: Submits the final design with measurements
  Future<void> createFabric() async {
    // Validate measurements
    if (!validateStep4()) {
      showMessage('Please enter all measurements', false);
      return;
    }

    isLoading.value = true;

    try {
      // Add a small delay to ensure the loading state is visible
      await Future.delayed(const Duration(milliseconds: 300));

      // Call the design repository to create the design
      final result = await designRepository.createFabric(
        designId: int.parse(selectedDesign.value!),
        width: double.parse(widthController.text),
        height: double.parse(heightController.text),
        numOfPieces: int.parse(numPatternsController.text),
      );

      // Handle the result
      result.when(
        success: (_) {
          designFinalized.value = true;
          showMessage('Fabric saved successfully!', true);
          // After creating fabric, fetch the fabric result
          fetchFabricResult(); // Added: Call fetchFabricResult after successful fabric creation
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

  // step 5: fetch fabric using designRepository.fetchFabricData
  Future<void> fetchFabricResult() async {
    isLoading.value = true;
    try {
      final result = await designRepository.fetchFabricData(
        fabricId: int.parse(selectedFabric.value!),
      );
      result.when(
        success: (fabric) {
          // On success, mark design as generated and move to the next step
          designGenerated.value = true;
          showMessage('Fabric fetched successfully!', true);
          goToStep(5); // Changed: Navigate to step 5 instead of step 2
        },
        failure: (error) {
          // On failure, show error message
          showMessage(error.message, false);
        },
      );
    } catch (e) {
      showMessage('An unexpected error occurred', false);
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToMyFabrics() {
    // First reset the current process
    resetProcess();
    // Then navigate to My Fabrics tab (index 3 in the tab routes)
    Get.find<MainLayoutController>().changeTab(3);
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
            // Use a separate container for the button to avoid layout shifts
            SizedBox(
              height: 60.h,
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
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
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
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
