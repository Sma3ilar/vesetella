import 'dart:io';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../utils/app_logger.dart';
part 'network_exceptions.freezed.dart';


@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.verificationSessionExpirationRequest(String message) = VerificationSessionExpirationRequest;

  const factory NetworkExceptions.resendOtpTriesExcessRequest(String message) = ResendOtpTriesExcessRequest;

  const factory NetworkExceptions.requestCancelled(String message) = RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest(String message) = UnauthorisedRequest;

  const factory NetworkExceptions.unProcessableEntityRequest(String message) = UnProcessableEntityRequest;

  const factory NetworkExceptions.forbiddenRequest(String message) = ForbiddenRequest;

  const factory NetworkExceptions.badRequest(String message) = BadRequest;

  const factory NetworkExceptions.notFound(String message) = NotFound;

  const factory NetworkExceptions.requestTimeout(String message) = RequestTimeout;

  const factory NetworkExceptions.receiveTimeout(String message) = ReceiveTimeout;

  const factory NetworkExceptions.sendTimeout(String message) = SendTimeout;

  const factory NetworkExceptions.noInternetConnection(String message) = NoInternetConnection;

  const factory NetworkExceptions.unableToProcess(String message) = UnableToProcess;

  const factory NetworkExceptions.defaultError(String message) = DefaultError;

  const factory NetworkExceptions.unexpectedError(String message) = UnexpectedError;

  static NetworkExceptions getDioException(dynamic error) {
    if (error is Exception) {
      try {
        if (error is DioException) { // Changed from DioError to DioException
          return _handleDioException(error);
        }

        logger.e('CoreNetworkExceptions', error: error.toString());

        if (error is SocketException) {
          return const NetworkExceptions.noInternetConnection('sorry_internet_connection_error');
        }

        return const NetworkExceptions.unexpectedError('sorry_something_went_wrong');
      } catch (_) {
        logger.e('CoreNetworkExceptions', error: error.toString());
        return const NetworkExceptions.unexpectedError('sorry_something_went_wrong');
      }
    }

    logger.e('CoreNetworkExceptions', error: error.toString());
    if (error.toString().contains("is not a subtype of")) {
      return const NetworkExceptions.unableToProcess('unable_to_process_data');
    }
    return const NetworkExceptions.unexpectedError('sorry_something_went_wrong');
  }

  static NetworkExceptions _handleDioException(DioException error) { // Changed from DioError to DioException
    switch (error.type) {
      case DioExceptionType.cancel: // Changed from DioErrorType to DioExceptionType
        return const NetworkExceptions.requestCancelled('request_canceled');
      case DioExceptionType.connectionTimeout: // Updated enum name
        return const NetworkExceptions.requestTimeout('request_timeout');
      case DioExceptionType.badResponse: // Replaces DioErrorType.response
        return _getDioNetworkException(error);
      case DioExceptionType.receiveTimeout: // Updated enum name
        return const NetworkExceptions.receiveTimeout('receive_timeout');
      case DioExceptionType.sendTimeout: // Updated enum name
        return const NetworkExceptions.sendTimeout('send_timeout');
      case DioExceptionType.connectionError: // New type for network issues
      case DioExceptionType.badCertificate: // New type in Dio 6
      case DioExceptionType.unknown: // Replaces DioErrorType.other
        return const NetworkExceptions.noInternetConnection('sorry_internet_connection_error');
    }
  }

  static NetworkExceptions _getDioNetworkException(DioException error) { // Changed from DioError to DioException
    switch (error.response?.statusCode) {
      case 400:
        String message = '';
        if (error.response?.data['message'] is List) {
          List<String> messages = List<String>.from(error.response!.data['message'].map((x) => x.toString()));
          message = messages.join('\n');
        } else {
          message = error.response?.data['message'] ?? 'Bad request';
        }
        return NetworkExceptions.badRequest(message);

      case 401:
        // Get.find<LogoutHelper>().perform();
        String message = error.response?.data['message'] ?? 'Unauthorized';
        return NetworkExceptions.unauthorisedRequest(message);

      // case 403:
      //   String message = error.response?.data['message'] ?? 'Forbidden';
      //   return NetworkExceptions.forbiddenRequest(message);

      case 403:
      // Get the specific error message from the response
        String message = 'Forbidden';
        if (error.response?.data != null) {
          if (error.response?.data['message'] != null) {
            message = error.response!.data['message'];
          }
        }
        return NetworkExceptions.forbiddenRequest(message);

      case 404:
        String message = error.response?.data['message'] ?? 'Not found';
        return NetworkExceptions.notFound(message);

      case 409:
        String message = error.response?.data['message'] ?? 'Conflict';
        return NetworkExceptions.unProcessableEntityRequest(message);

      // case 422:
      //   String message = error.response?.data['message'] ?? 'Unprocessable entity';
      //   return NetworkExceptions.unProcessableEntityRequest(message);

      case 422:
      // Extract error message from the errors object
        if (error.response?.data != null && error.response?.data['errors'] != null) {
          final errorsMap = error.response!.data['errors'] as Map<String, dynamic>;
          // Take the first error field and its first message
          if (errorsMap.isNotEmpty) {
            final firstField = errorsMap.keys.first;
            final fieldErrors = errorsMap[firstField];
            if (fieldErrors is List && fieldErrors.isNotEmpty) {
              return NetworkExceptions.unProcessableEntityRequest(fieldErrors.first.toString());
            }
          }
        }

        // Fallback to message or default
        String message = error.response?.data['message'] ?? 'Validation failed';
        return NetworkExceptions.unProcessableEntityRequest(message);

      case 419:
        String message = error.response?.data?['message'] ?? 'Session expired';
        return NetworkExceptions.verificationSessionExpirationRequest(message);

      case 432:
        String message = error.response?.data?['message'] ?? 'OTP tries exceeded';
        return NetworkExceptions.resendOtpTriesExcessRequest(message);

      default:
        return NetworkExceptions.defaultError('Invalid status code ${error.response?.statusCode ?? "unknown"}');
    }
  }
}

extension CoreNetworkExceptionsExtension on NetworkExceptions {
  String get message {
    String value = '';
    whenOrNull(
      verificationSessionExpirationRequest: (message) => value = message,
      resendOtpTriesExcessRequest: (message) => value = message,
      requestCancelled: (message) => value = message,
      unProcessableEntityRequest: (message) => value = message,
      forbiddenRequest: (message) => value = message,
      badRequest: (message) => value = message,
      notFound: (message) => value = message,
      requestTimeout: (message) => value = message,
      receiveTimeout: (message) => value = message,
      sendTimeout: (message) => value = message,
      noInternetConnection: (message) => value = message,
      unableToProcess: (message) => value = message,
      defaultError:(message) => value = message,
      unexpectedError: (message) => value = message,
      unauthorisedRequest: (message) => value = message,
    );

    return value;
  }
}