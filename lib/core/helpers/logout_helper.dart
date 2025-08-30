import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pg_web/presentation/widgets/snack_bar.dart';
import 'package:rxdart/rxdart.dart';
import '../constants/tr_keys.dart';
import 'local_storage.dart';

class LogoutHelper extends GetxService {
  final LocalStorage localStorage;

  // Private subject to emit logout events
  final _onLoggingOutController = BehaviorSubject<void>();

  // Expose the subject as a stream
  Stream<void> get onLoggingOut => _onLoggingOutController.stream;

  LogoutHelper({required this.localStorage});

  void perform() {
    try {
      // Notify listeners that logout is happening
      _onLoggingOutController.add(null);

      // Get.find<LoginController>().logout();

      localStorage.logout();
      Get.back();
      showMessage(TrKeys.logoutSuccess, true);
      // Get.offAllNamed(AppRoutes.root);
    } catch (e) {
      // Handle errors (e.g., log them or show a message to the user)
      if (kDebugMode) {
        print('Error during logout: $e');
      }
    }
  }

  void dispose() {
    _onLoggingOutController.close();
  }
}
