import 'local_storage.dart';

class TokenService {
  String getToken() {
    return LocalStorage.instance.getToken();
  }
}