import 'package:dio/dio.dart';
import 'package:pg_web/presentation/widgets/snack_bar.dart';
import '../core/constants/tr_keys.dart';
import '../core/helpers/api_result.dart';
import '../core/helpers/dio_api_manager.dart';
import '../core/helpers/network_exceptions.dart';
import '../core/helpers/token_interceptor.dart';
import '../models/data/fabric_item_model.dart';
import '../models/data/new_design_model.dart';
import '../models/response/create_fabric_response_model.dart';

class DesignRepository {
  final DioApiManager apiManager;
  final TokenService tokenService;

  DesignRepository({required this.apiManager, required this.tokenService});

  // ####################### Designs #########################################

  Future<CoreApiResult<DesignList>> fetchDesigns({required int page}) async {
    try {
      final token = tokenService.getToken();
      final Response response = await apiManager.dio.get(
        "/products",
        queryParameters: {"page": page},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final productList = DesignList.fromJson(response.data);

      return CoreApiResult.success(data: productList);
    } catch (e) {
      final error = NetworkExceptions.getDioException(e);
      return CoreApiResult.failure(error: error);
    }
  }

  Future<CoreApiResult<void>> createDesign({
    required String sleeveType,
    required String collarType,
    required String color,
    required String fabricType,
    required String size,
  }) async {
    try {
      final token = tokenService.getToken();

      final Map<String, dynamic> designData = {
        'sleeve_type': sleeveType,
        'collar_type': collarType,
        'color': color,
        'fabric_type': fabricType,
        'size': size,
      };

      // Make the POST request using DioApiManager
      final response = await apiManager.dio.post(
        '/create_designs',
        data: designData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // Check for success
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        return CoreApiResult.success(data: null); // No data to return
      } else {
        // Handle API errors
        final error = NetworkExceptions.defaultError(
          TrKeys.failedToCreateDesign,
        );
        return CoreApiResult.failure(error: error);
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors (e.g., network issues)
      final error = NetworkExceptions.getDioException(e);
      return CoreApiResult.failure(error: error);
    } catch (e) {
      // Handle other errors
      final error = NetworkExceptions.getDioException(e);
      return CoreApiResult.failure(error: error);
    }
  }

  Future<CoreApiResult<void>> deleteDesign(int designId) async {
    try {
      final token = tokenService.getToken();

      // Make the POST request using DioApiManager
      final response = await apiManager.dio.delete(
        '/delete_design/$designId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // Check for success
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        showMessage(TrKeys.designDeletedSuccessfully, true);
        return CoreApiResult.success(data: null); // No data to return
      } else {
        // Handle API errors
        final error = NetworkExceptions.defaultError(
          TrKeys.failedToDeleteDesign,
        );
        showMessage(error.message, false);
        return CoreApiResult.failure(error: error);
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors (e.g., network issues)
      final error = NetworkExceptions.getDioException(e);
      showMessage(error.message, false);
      return CoreApiResult.failure(error: error);
    } catch (e) {
      // Handle other errors
      final error = NetworkExceptions.getDioException(e);
      showMessage(error.message, false);
      return CoreApiResult.failure(error: error);
    }
  }

  Future<CoreApiResult<void>> createFabric({
    required int designId,
    required double width,
    required double height,
    required int numOfPieces,
  }) async {
    try {
      final token = tokenService.getToken();

      final Map<String, dynamic> fabricData = {
        'design_id': designId,
        'width': width,
        'height': height,
        'num_of_pieces': numOfPieces,
      };

      // Make the POST request using DioApiManager
      final response = await apiManager.dio.post(
        '/create_fabric',
        data: fabricData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Check for success
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        return CoreApiResult.success(data: null); // No data to return
      } else {
        // Handle API errors
        final error = NetworkExceptions.defaultError('Failed to create fabric');
        return CoreApiResult.failure(error: error);
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors (e.g., network issues)
      final error = NetworkExceptions.getDioException(e);
      return CoreApiResult.failure(error: error);
    } catch (e) {
      // Handle other errors
      final error = NetworkExceptions.getDioException(e);
      return CoreApiResult.failure(error: error);
    }
  }

  Future<CoreApiResult<void>> deleteFabric(int fabricId) async {
    try {
      final token = tokenService.getToken();

      // Make the DELETE request using DioApiManager
      final response = await apiManager.dio.delete(
        '/delete_fabric/$fabricId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // Check for success
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        showMessage('Fabric deleted successfully', true);
        return CoreApiResult.success(data: null); // No data to return
      } else {
        // Handle API errors
        final error = NetworkExceptions.defaultError('Failed to delete fabric');
        showMessage(error.message, false);
        return CoreApiResult.failure(error: error);
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors (e.g., network issues)
      final error = NetworkExceptions.getDioException(e);
      showMessage(error.message, false);
      return CoreApiResult.failure(error: error);
    } catch (e) {
      // Handle other errors
      final error = NetworkExceptions.getDioException(e);
      showMessage(error.message, false);
      return CoreApiResult.failure(error: error);
    }
  }

  Future<CoreApiResult<NewDesignModel>> fetchDesignData({
    required int designId,
  }) async {
    try {
      final token = tokenService.getToken();
      final Response response = await apiManager.dio.get(
        "/designs/$designId",
        // queryParameters: {"page": page},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final design = NewDesignModel.fromJson(response.data['data']);
      return CoreApiResult.success(data: design);
    } catch (e) {
      final error = NetworkExceptions.getDioException(e);
      return CoreApiResult.failure(error: error);
    }
  }

  Future<CoreApiResult<CreateFabricResponseModel>> fetchFabricData({
    required int fabricId,
  }) async {
    try {
      final token = tokenService.getToken();
      final Response response = await apiManager.dio.get(
        "/fabrics/$fabricId",
        // queryParameters: {"page": page},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final fabric = CreateFabricResponseModel.fromJson(response.data['data']);
      return CoreApiResult.success(data: fabric);
    } catch (e) {
      final error = NetworkExceptions.getDioException(e);
      return CoreApiResult.failure(error: error);
    }
  }
}
