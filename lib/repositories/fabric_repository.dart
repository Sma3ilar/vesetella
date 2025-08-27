import 'package:dio/dio.dart';
import 'package:pg_web/core/extensions/translation_extension.dart';
import 'package:pg_web/presentation/widgets/snack_bar.dart';
import '../core/constants/tr_keys.dart';
import '../core/helpers/api_result.dart';
import '../core/helpers/dio_api_manager.dart';
import '../core/helpers/network_exceptions.dart';
import '../core/helpers/token_interceptor.dart';

class FabricRepository {
  final DioApiManager apiManager;
  final TokenService tokenService;

  FabricRepository({required this.apiManager, required this.tokenService});

  // ####################### Fabrics #########################################

  Future<CoreApiResult<void>> createFabric(FormData formData) async {
    try {
      final token = tokenService.getToken();

      // Make the POST request using DioApiManager
      final response = await apiManager.dio.post(
        '/create_fabric',
        data: formData,
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

  Future<CoreApiResult<void>> updateFabric(
    FormData formData,
    int fabricId,
  ) async {
    try {
      final token = tokenService.getToken();

      // Make the PATCH request using DioApiManager
      final response = await apiManager.dio.patch(
        '/update_fabric/$fabricId',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // Check for success
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        return CoreApiResult.success(data: null); // No data to return
      } else {
        // Handle API errors
        final error = NetworkExceptions.defaultError('Failed to update fabric');
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
}
