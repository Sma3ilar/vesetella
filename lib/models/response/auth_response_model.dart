import '../data/user_model.dart';

class AuthResponseModel {
  final UserData? data;
  final String? accessToken;

  AuthResponseModel({this.data, this.accessToken});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      accessToken: json['access_token'],
    );
  }
}
