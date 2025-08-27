import 'package:get/get.dart';

import '../../models/data/fabric_item_model.dart';
import '../../repositories/fabric_repository.dart';

class MyFabricsController extends GetxController {
  final FabricRepository fabricRepository;
  
  // State for loading indicator
  final RxBool isLoading = true.obs;

  // An observable list to hold the user's fabrics
  final RxList<FabricItemModel> fabrics = <FabricItemModel>[].obs;

  MyFabricsController({required this.fabricRepository});

  @override
  void onInit() {
    super.onInit();
    fetchFabrics();
  }

  /// Fetches fabrics from the API or uses dummy data if API fails
  Future<void> fetchFabrics() async {
    try {
      isLoading.value = true;
      
      // In a real implementation, you would call the repository here
      // For now, we'll use dummy data
      _loadDummyFabrics();
    } catch (e) {
      // Handle potential errors
      print("Error fetching fabrics: $e");
      _loadDummyFabrics();
    } finally {
      isLoading.value = false;
    }
  }
  
  /// Loads dummy fabric data for testing
  void _loadDummyFabrics() {
    // Create a list of dummy data
    final dummyFabrics = List.generate(
      8, // Create 8 sample fabrics
      (index) => FabricItemModel(
        id: '$index',
        title: 'Default Title',
        color: 'Red',
        number: '${index + 1}',
        type: 'Cotton',
        // Use a placeholder image
        imagePath: 'assets/images/fabric_placeholder.png',
      ),
    );

    fabrics.assignAll(dummyFabrics);
  }
}
