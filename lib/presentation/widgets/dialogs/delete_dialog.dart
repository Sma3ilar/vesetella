import 'package:flutter/material.dart';
import 'package:pg_web/core/extensions/translation_extension.dart';
import 'package:pg_web/core/theme/app_styles.dart';
import 'package:pg_web/presentation/widgets/app_button.dart';

import '../../../core/constants/tr_keys.dart';
import '../../../core/theme/colors.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String title;

  const ConfirmDeleteDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Text(TrKeys.confirmDeletion.trn),
      content: Text(
        '${TrKeys.areYouSureYouWantToDelete.trn} $title${TrKeys.questionMark.trn}',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            TrKeys.cancel.trn,
            style: AppStyles.textStyle500(color: AppColors.black),
          ),
        ),
        AppButton(
          buttonColor: AppColors.red,
          text: TrKeys.delete.trn,
          textStyle: AppStyles.buttonTextStyle(color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
