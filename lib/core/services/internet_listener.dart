import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetListener {
  static final InternetListener _instance = InternetListener._internal();
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;

  factory InternetListener() {
    return _instance;
  }

  InternetListener._internal();

  void startListening(Function onInternetRestored) {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        onInternetRestored();
      }
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
