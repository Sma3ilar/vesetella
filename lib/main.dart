// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_widget.dart';
import 'core/helpers/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await LocalStorage.init();
  } catch (e) {
    print('LocalStorage initialization failed: $e');
    // Continue without local storage or show error
  }
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await EasyLocalization.ensureInitialized();

  // await GetStorage.init();
  // await FlutterLocalization.instance.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await FirebaseAPI().initNotification();

  runApp(MyApp());
}
