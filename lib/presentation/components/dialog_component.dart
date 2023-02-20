import 'package:dictionary/presentation/styles/app_colors.dart';
import 'package:dictionary/presentation/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogComponent {
  DialogComponent._();

  static Future showdialog({
    required ctx,
    required String title,
    required String subtitle,
  }) =>
      showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
          title: Center(
            child: Text(
              title,
              style: AppTextStyles.medium.copyWith(
                fontSize: 18.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          content: Text(
            subtitle,
            style: AppTextStyles.regular.copyWith(
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(
                "okay",
                style: AppTextStyles.medium.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      );
}
