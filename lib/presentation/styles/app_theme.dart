import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.light,
    backgroundColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.white,
    hintColor: AppColors.primaryColor,
    textTheme: TextTheme(
      /// for HeadLine which color black
      headline1: AppTextStyles.bold
          .copyWith(fontSize: 28.sp, color: AppColors.primaryColor),

      /// for HeadLine which color pink
      headline2: AppTextStyles.bold
          .copyWith(fontSize: 28.sp, color: AppColors.secondaryColor),

      /// for Headline which is AppBar
      headline3: AppTextStyles.medium
          .copyWith(fontSize: 22.sp, color: AppColors.primaryColor),

      /// for Photo body HeadLine
      headline4: AppTextStyles.medium
          .copyWith(fontSize: 16.sp, color: AppColors.primaryColor),

      /// for bottomNavigationBar
      subtitle1: AppTextStyles.regular
          .copyWith(fontSize: 12.sp, color: AppColors.primaryColor),

      /// for Bad, Good, Amazing
      subtitle2: AppTextStyles.regular
          .copyWith(fontSize: 14.sp, color: AppColors.disabledTextColor),

      /// for bodyText which is hint TextFormField and etc
      bodyText1: AppTextStyles.regular
          .copyWith(fontSize: 16.sp, color: AppColors.primaryColor),

      /// for bodyText
      bodyText2: AppTextStyles.regular
          .copyWith(fontSize: 14.sp, color: AppColors.primaryColor),

      /// for another caption
      caption: AppTextStyles.medium
          .copyWith(fontSize: 16.sp, color: AppColors.white),

      /// for button
      button: AppTextStyles.regular
          .copyWith(fontSize: 16.sp, color: AppColors.white),
    ),
  );

  static ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      brightness: Brightness.light,
      backgroundColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,
      hintColor: AppColors.primaryColor,
      textTheme: TextTheme(
        /// for HeadLine which color black
        headline1: AppTextStyles.bold
            .copyWith(fontSize: 28.sp, color: AppColors.primaryColor),

        /// for HeadLine which color pink
        headline2: AppTextStyles.bold
            .copyWith(fontSize: 28.sp, color: AppColors.secondaryColor),

        /// for Headline which is AppBar
        headline3: AppTextStyles.medium
            .copyWith(fontSize: 22.sp, color: AppColors.primaryColor),

        /// for Photo body HeadLine
        headline4: AppTextStyles.medium
            .copyWith(fontSize: 16.sp, color: AppColors.primaryColor),

        /// for bottomNavigationBar
        subtitle1: AppTextStyles.regular
            .copyWith(fontSize: 12.sp, color: AppColors.primaryColor),

        /// for Bad, Good, Amazing
        subtitle2: AppTextStyles.regular
            .copyWith(fontSize: 14.sp, color: AppColors.disabledTextColor),

        /// for bodyText which is hint TextFormField and etc
        bodyText1: AppTextStyles.regular
            .copyWith(fontSize: 16.sp, color: AppColors.primaryColor),

        /// for bodyText
        bodyText2: AppTextStyles.regular
            .copyWith(fontSize: 14.sp, color: AppColors.primaryColor),

        /// for another caption
        caption: AppTextStyles.medium
            .copyWith(fontSize: 16.sp, color: AppColors.white),

        /// for button
        button: AppTextStyles.regular
            .copyWith(fontSize: 16.sp, color: AppColors.white),
      ));
}
