import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

enum ShareType {
  company('companies'),
  product('products'),
  spec('eng_specifications'),
  news('news'),
  partner('partners'),
  engineering('engineerings'),
  workshop('workshops'),
  service('services'),
  about('abouts'),
  policy('policies');

  final String path;
  const ShareType(this.path);
}

extension ShareUrl on BuildContext {
  static const _devBase = 'https://test.khan-alhandasah.com';
  static const _prodBase = 'https://khan-alhandasah.com';

  String buildShareUrl(ShareType type, String id) {
    final base = kReleaseMode ? _prodBase : _devBase;
    final locale = Localizations.localeOf(this).languageCode;
    return '$base/$locale/${type.path}/$id';
  }
}


// Usage:
//        final url = context.buildShareUrl(ShareType.company, companyID);
