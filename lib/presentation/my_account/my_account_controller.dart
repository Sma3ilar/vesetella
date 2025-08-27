import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import '../../models/data/user_model.dart';
import '../../repositories/auth_repository.dart';

class MyAccountController extends GetxController {
  // Repository for authentication and user profile operations
  final AuthRepository authRepository;
  
  MyAccountController({required this.authRepository});
  // State for loading indicator
  final RxBool isLoading = true.obs;

  // An observable to hold the user's data. It's nullable to handle the loading state.
  final Rx<UserModelData?> user = Rx<UserModelData?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  /// Fetches user profile data from the API.
  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      
      // Attempt to fetch profile from API
      final result = await authRepository.fetchProfileInfo();
      
      // Use the when pattern to handle the result
      result.when(
        success: (data) {
          if (data != null) {
            // Convert UserModel to UserModelData
            user.value = UserModelData(
              id: '12345', // ID is not provided by the API, using a placeholder
              name: data.name,
              email: data.email,
            );
          } else {
            _loadDummyUser();
          }
        },
        failure: (error) {
          _loadDummyUser();
          
          // Show error only if it's not in development environment
          if (!kIsWeb) {
            Get.snackbar('Error', error.message ?? 'Could not fetch profile data.');
          }
        },
      );
    } catch (e) {
      // Fallback to dummy data in case of exception
      _loadDummyUser();
      
      Get.snackbar('Error', 'Could not fetch profile data.');
      print("Error fetching user profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Loads dummy user data as fallback
  void _loadDummyUser() {
    user.value = UserModelData(
      id: '12345',
      name: 'Vestella User',
      email: 'user@vestella.com',
    );
  }

  /// Placeholder for edit profile functionality.
  void editProfile() {
    Get.snackbar(
      'Coming Soon',
      'Edit profile functionality is not yet implemented.',
    );
  }

  /// Placeholder for change password functionality.
  void changePassword() {
    Get.snackbar(
      'Coming Soon',
      'Change password functionality is not yet implemented.',
    );
  }
}
