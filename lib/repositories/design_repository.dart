import 'package:dio/dio.dart';
import 'package:pg_web/core/extensions/translation_extension.dart';
import 'package:pg_web/presentation/widgets/snack_bar.dart';
import '../core/constants/tr_keys.dart';
import '../core/helpers/api_result.dart';
import '../core/helpers/dio_api_manager.dart';
import '../core/helpers/network_exceptions.dart';
import '../core/helpers/token_interceptor.dart';
import '../models/data/new_design_model.dart';

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

  Future<CoreApiResult<NewDesignModel>> fetchDesignData({
    required int productID,
  }) async {
    try {
      final token = tokenService.getToken();
      final Response response = await apiManager.dio.get(
        "/products/$productID",
        // queryParameters: {"page": page},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final product = NewDesignModel.fromJson(response.data['data']);
      return CoreApiResult.success(data: product);
    } catch (e) {
      final error = NetworkExceptions.getDioException(e);
      return CoreApiResult.failure(error: error);
    }
  }

  Future<CoreApiResult<void>> createDesign(FormData formData) async {
    try {
      final token = tokenService.getToken();

      // Make the POST request using DioApiManager
      final response = await apiManager.dio.post(
        '/create_designs',
        data: formData,
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

  Future<CoreApiResult<void>> editDesign(
    FormData formData,
    int designId,
  ) async {
    try {
      final token = tokenService.getToken();

      // Make the POST request using DioApiManager
      final response = await apiManager.dio.patch(
        '/update_design/$designId',
        data: formData,
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
}
