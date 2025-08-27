import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_constants.dart';
import '../../core/helpers/local_storage.dart';
import '../../core/theme/app_styles.dart';
import '../../core/theme/colors.dart';
import 'back_button.dart';

class NewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isBackButton, hideAdd;
  final VoidCallback? onActionPressed;
  final String? title;
  const NewAppBar({
    super.key,
    this.isBackButton = false,
    this.hideAdd = false,
    this.onActionPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAuth = LocalStorage.instance.getIsAuth();
    final bool isEngineer =
        LocalStorage.instance.getRole() == UserType.companies.name;
    return AppBar(
      backgroundColor: isBackButton
          ? (title == null)
                ? AppColors.white
                : AppColors.blue50
          : AppColors.blue50,
      elevation: 0.0, // Sets the shadow's size beneath the AppBar
      // shadowColor: AppColors.black
      //     .withValues(alpha: 0.35), // Defines the shadow color and opacity
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(38.85),
          bottomRight: Radius.circular(38.85),
        ),
      ),
      leading: isBackButton ? MyBackButton() : _buildIconDrawer(),
      actions: [
        if (isAuth && isEngineer && !hideAdd) ...[
          InkWell(
            onTap: () {
              // Get.dialog(const AddChoiceDialog());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.w),
              child: SvgPicture.asset(
                AppAssets.iconAdd,
                fit: BoxFit.cover,
                width: 36,
                height: 36,
              ),
            ),
          ),
        ] else if (title != null)
          _buildLogo(),
      ],
      title: (title != null) ? _buildTitle() : _buildLogo(),
      // : _buildJoinUs(),
      centerTitle: true,
    );
  }

  Padding _buildIconDrawer() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        28.w,
        18,
        0,
        18,
      ), // Increase this to push it inward
      child: IconButton(
        onPressed: onActionPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: SizedBox(
          width: 36,
          height: 36,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 24,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.blue500,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                width: 18,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.blue500,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                width: 24,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.blue500,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        AppAssets.logoPng,
        height: 48.h,
        width: 88.w,
        // fit: BoxFit.cover,
      ),
    );
  }

  Text _buildTitle() {
    return Text(title!, style: AppStyles.textStyle500(color: AppColors.black));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


/*
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isBackButton, isLogin;
  final VoidCallback? onActionPressed;
  final String? title;
  const MainAppBar({
    super.key,
    this.isBackButton = false,
    this.isLogin = false,
    this.onActionPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 3.0, // Sets the shadow's size beneath the AppBar
      shadowColor: AppColors.black
          .withValues(alpha: 0.35), // Defines the shadow color and opacity
      surfaceTintColor: Colors.transparent,
      shape: const Border(
        bottom: BorderSide(
          color: Color(0xFFCAC4D0),
          width: 1, // Thickness of the bottom border
        ),
      ),
      leading: isBackButton
          ? MyBackButton()
          : IconButton(
        onPressed: onActionPressed,
        icon: const Icon(Icons.menu, color: Colors.black),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AppAssets.logoPng,
            height: 48,
            width: 48,
            // fit: BoxFit.cover,
          ),
        ),
      ],
      title: (title != null)
          ? _buildTitle()
          : _buildJoinUs(),
      centerTitle: true,
    );
  }

  Text _buildTitle() {
    return Text(
      title!,
      style: AppStyles.textStyle500(
        color: AppColors.black,
      ),
    );
  }

  GestureDetector _buildJoinUs() {
    return (isLogin)
        ? GestureDetector(
      onTap: () {
        Get.offNamed(AppRoutes.loginScreen);
        // Get.toNamed(AppRoutes.engineerRegister);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.login_outlined,
              color: AppColors.darkBlue, size: 16),
          4.horizontalSpace,
          Text(
            TrKeys.login.trn,
            style:
            AppStyles.textStyle600(color: AppColors.darkBlue),
          ),
        ],
      ),
    )
        : GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.joinUsScreen);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat_bubble,
              color: AppColors.darkBlue, size: 16),
          4.horizontalSpace,
          Text(
            TrKeys.joinUs.trn,
            style:
            AppStyles.textStyle600(color: AppColors.darkBlue),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
*/

