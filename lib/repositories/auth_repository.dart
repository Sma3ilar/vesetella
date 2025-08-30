import 'package:dio/dio.dart';
import 'package:pg_web/core/constants/tr_keys.dart';
import '../core/helpers/api_result.dart';
import '../core/helpers/dio_api_manager.dart';
import '../core/helpers/network_exceptions.dart';
import '../core/helpers/token_interceptor.dart';
import '../models/data/user_model.dart';
import '../models/request/signup_request.dart';
import '../models/response/auth_response_model.dart';

class AuthRepository {
  final DioApiManager apiManager;
  final TokenService tokenService;

  AuthRepository({required this.apiManager, required this.tokenService});

  // Future<CoreApiResult<BaseInfoModel>> fetchInitialSettings() async {
  //   try {
  //     // final token = tokenService.getToken();
  //     final Response response = await apiManager.dio.get("/settings");
  //     final settings = BaseInfoModel.fromJson(response.data);
  //     return CoreApiResult.success(data: settings);
  //   } catch (e) {
  //     final error = NetworkExceptions.getDioException(e);
  //     return CoreApiResult.failure(error: error);
  //   }
  // }

  Future<CoreApiResult<AuthResponseModel>> register(
    SignupRequest request,
  ) async {
    try {
      // Make the POST request using DioApiManager
      final response = await apiManager.dio.post(
        '/register', // Replace with your API endpoint
        data: request.toJson(),
      );

      // Check for success
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success - parse the response data
        final authResponse = AuthResponseModel.fromJson(response.data);
        return CoreApiResult.success(data: authResponse);
      } else {
        // Handle API errors
        final error = NetworkExceptions.defaultError(TrKeys.failedToRegister);
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

  Future<CoreApiResult<AuthResponseModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await apiManager.dio.post(
        '/login',
        data: {'email': username, 'password': password},
      );

      // Check for success
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Check if the response contains a status field indicating failure
        if (response.data is Map &&
            response.data['status'] != null &&
            response.data['status'] == false) {
          // Handle API logical errors (status: false)
          final errorMessage = response.data['msg'] ?? TrKeys.failedToLogin;
          final error = NetworkExceptions.defaultError(errorMessage);
          return CoreApiResult.failure(error: error);
        }

        // Success
        final user = AuthResponseModel.fromJson(response.data);
        return CoreApiResult.success(data: user);
      } else {
        // Handle API errors
        final error = NetworkExceptions.defaultError(TrKeys.failedToLogin);
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

  Future<CoreApiResult<bool>> logout() async {
    try {
      final token = tokenService.getToken();
      final response = await apiManager.dio.post(
        '/logout',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // Check for success
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        return CoreApiResult.success(data: true);
      } else {
        // Handle API errors
        final error = NetworkExceptions.defaultError(TrKeys.failedToLogout);
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

  //////// Profile
  Future<CoreApiResult<UserModelData>> fetchProfileInfo() async {
    try {
      final token = tokenService.getToken();
      final Response response = await apiManager.dio.get(
        "/show-profile",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final profile = UserModelData.fromJson(response.data['user']);
      return CoreApiResult.success(data: profile);
    } catch (e) {
      final error = NetworkExceptions.getDioException(e);
      return CoreApiResult.failure(error: error);
    }
  }
}
