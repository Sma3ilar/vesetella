import 'package:freezed_annotation/freezed_annotation.dart';
import 'network_exceptions.dart';

part 'api_result.freezed.dart';

@freezed
class CoreApiResult<T> with _$CoreApiResult<T> {
  const factory CoreApiResult.success({T? data}) = Success<T>;

  const factory CoreApiResult.failure({required NetworkExceptions error}) = Failure<T>;
}