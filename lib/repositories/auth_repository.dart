import 'package:dio/dio.dart';
import 'package:pg_web/core/constants/tr_keys.dart';
import 'package:pg_web/core/extensions/translation_extension.dart';
import '../core/helpers/api_result.dart';
import '../core/helpers/dio_api_manager.dart';
import '../core/helpers/network_exceptions.dart';
import '../core/helpers/token_interceptor.dart';
import '../models/data/user_model';
import '../models/request/signup_request.dart';
import '../models/response/login_response_model';

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

  Future<CoreApiResult<void>> register(SignupRequest request) async {
    try {
      // Make the POST request using DioApiManager
      final response = await apiManager.dio.post(
        '/register', // Replace with your API endpoint
        data: request.toJson(),
      );

      // Check for success
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        return CoreApiResult.success(data: null); // No data to return
      } else {
        // Handle API errors
        final error = NetworkExceptions.defaultError(
          TrKeys.failedToRegister.trn,
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

  Future<CoreApiResult<LoginResponse>> login({
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
        // Success
        final user = LoginResponse.fromJson(response.data);
        return CoreApiResult.success(data: user);
      } else {
        // Handle API errors
        final error = NetworkExceptions.defaultError("Failed to login");
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
        final error = NetworkExceptions.defaultError(TrKeys.failedToLogout.trn);
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
  Future<CoreApiResult<UserModel>> fetchProfileInfo() async {
    try {
      final token = tokenService.getToken();
      final Response response = await apiManager.dio.get(
        "/show-profile",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final profile = UserModel.fromJson(response.data['user']);
      return CoreApiResult.success(data: profile);
    } catch (e) {
      final error = NetworkExceptions.getDioException(e);
      return CoreApiResult.failure(error: error);
    }
  }
}
