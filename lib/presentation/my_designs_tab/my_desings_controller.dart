import 'package:get/get.dart';

import '../../models/data/design_item_model.dart';
import '../../repositories/design_repository.dart';

class MyDesignsController extends GetxController {
  final DesignRepository designRepository;

  // State for loading indicator
  final RxBool isLoading = true.obs;

  // An observable list to hold the user's designs
  final RxList<DesignItemModel> designs = <DesignItemModel>[].obs;

  MyDesignsController({required this.designRepository});

  @override
  void onInit() {
    super.onInit();
    fetchDesigns();
  }

  /// Fetches designs from the API or uses dummy data if API fails
  Future<void> fetchDesigns() async {
    try {
      isLoading.value = true;

      // Try to fetch from API (page 1)
      final result = await designRepository.fetchDesigns(page: 1);

      result.when(
        success: (designList) {
          // If we have real data, convert it to DesignItemModel format
          if (designList != null && designList.designs.isNotEmpty) {
            // This would need proper conversion from NewDesignModel to DesignItemModel
            // For now, we'll use dummy data
            _loadDummyDesigns();
          } else {
            _loadDummyDesigns();
          }
        },
        failure: (_) {
          // On failure, load dummy data
          _loadDummyDesigns();
        },
      );
    } catch (e) {
      // Handle potential errors
      print("Error fetching designs: $e");
      _loadDummyDesigns();
    } finally {
      isLoading.value = false;
    }
  }

  /// Loads dummy design data for testing
  void _loadDummyDesigns() {
    // Create a list of dummy data
    final dummyDesigns = List.generate(
      6, // Create 6 sample designs
      (index) => DesignItemModel(
        id: '$index',
        title: 'Default Title',
        color: 'Blue',
        number: '${index + 1}',
        fabric: 'Denim',
        imagePaths: [
          // Use the same placeholder image for now
          'assets/images/jacket.png',
          'assets/images/jacket.png',
          'assets/images/jacket.png',
        ],
      ),
    );

    designs.assignAll(dummyDesigns);
  }
}
