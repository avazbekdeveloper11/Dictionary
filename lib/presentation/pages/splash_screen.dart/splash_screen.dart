import 'package:dictionary/presentation/styles/app_colors.dart';
import 'package:dictionary/presentation/styles/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage("assets/pictures/dictionary_book.jpg"),
              radius: 90.r,
            ),
            SizedBox(height: 16.h),
            Text(
              "dictionary".tr(),
              style: AppTextStyles.medium.copyWith(
                color: Colors.white,
                fontSize: 32.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
