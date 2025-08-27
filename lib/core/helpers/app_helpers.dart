import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:pg_web/presentation/widgets/snack_bar.dart';

bool isValidEmail(String email) {
  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  return emailRegex.hasMatch(email);
}

bool isValidPhone(String phone) {
  final phoneRegex = RegExp(r'^\+?\d{7,15}$');
  return phoneRegex.hasMatch(phone);
}

bool isValidSyrianPhone(String phone) {
  final phoneRegex = RegExp(r"^(\+963|0)?(9[3-9])\d{7}$");
  return phoneRegex.hasMatch(phone);
}

// bool validateCaptcha(
//   LocalCaptchaController captchaController,
//   TextEditingController codeController,
// ) {
//   String enteredCode = codeController.text;
//   LocalCaptchaValidation validation = captchaController.validate(enteredCode);
//   bool isValid = (validation == LocalCaptchaValidation.valid);
//   if (!isValid) {
//     captchaController.refresh();
//   }
//   codeController.clear();
//   return isValid;
// }

Future<void> pickFile(
  TextEditingController controller,
  Function(File?) setFile,
  VoidCallback update,
) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
    withData: false, // optional, depends on whether you use file path or bytes
  );

  if (result != null && result.files.single.path != null) {
    final file = File(result.files.single.path!);
    setFile(file);
    controller.text = result.files.single.name;
    update();
  }
}

/*
Future<void> pickFile(
  TextEditingController controller,
  ValueSetter<File?> setFile,
  VoidCallback update
) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    final file = File(result.files.single.path!);
    setFile(file);
    controller.text = result.files.single.name;
    update();
  }
}

*/

// Quick check using regex. You can expand this if you need to do specific link type logic.
bool isUrl(String? text) {
  if (text == null || text.trim().isEmpty || text.trim() == "--") return false;
  final regex = RegExp(r'^(https?:\/\/)');
  return regex.hasMatch(text.trim());
}

// Normalizes URL if the user might have omitted https://
String normalizeUrl(String url) {
  url = url.trim();
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    return 'https://$url';
  }
  return url;
}

// Future<void> visitWebsite(BuildContext context, String url) async {
//   final normalizedUrl = normalizeUrl(url);
//   try {
//     if (await canLaunchUrlString(normalizedUrl)) {
//       await launchUrlString(normalizedUrl);
//     } else {
//       throw 'Could not launch URL';
//     }
//   } catch (e) {
//     showMessage('Could not launch URL: $normalizedUrl', false);
//   }
// }

String extractFileName(String? url) {
  if (url == null) {
    return '';
  }
  return Uri.parse(url).pathSegments.last;
}

String extractTitles(List<dynamic> items) {
  return items.map((e) => e.title).whereType<String>().join(', ');
}

String keepValidDecimalNumber(String input) {
  // Remove all non-numeric and non-decimal characters
  String cleaned = input.replaceAll(RegExp(r'[^0-9.]'), '');

  // Handle multiple decimal points
  int decimalIndex = cleaned.indexOf('.');
  if (decimalIndex != -1) {
    // Keep only the first decimal point and numbers after it
    cleaned =
        '${cleaned.substring(0, decimalIndex)}.${cleaned.substring(decimalIndex + 1).replaceAll('.', '')}';
  }

  // Remove decimal point if it's at start or end
  if (cleaned.startsWith('.')) {
    cleaned = cleaned.substring(1);
  }
  if (cleaned.endsWith('.')) {
    cleaned = cleaned.substring(0, cleaned.length - 1);
  }

  return cleaned;
}
