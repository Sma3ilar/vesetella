import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_web/core/extensions/translation_extension.dart';

import '../../core/constants/tr_keys.dart';

class MyErrorWidget extends StatelessWidget {
  final Function onTapped;
  final int? stateCode;
  final String? error;
  const MyErrorWidget({
    super.key,
    required this.onTapped,
    this.stateCode,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapped();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            25.verticalSpace,
            if (stateCode != null && kDebugMode) Text('$stateCode'),
            if (error != null && kDebugMode) Text('$error', maxLines: 2),
            Text('${TrKeys.error} !'),
            24.verticalSpace,
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.refresh,
                  color: Colors.black12,
                  size: 20,
                  grade: 0.1,
                ),
                4.verticalSpace,
                Text(TrKeys.tryAgain),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
