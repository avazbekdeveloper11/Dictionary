import 'package:dictionary/presentation/styles/app_colors.dart';
import 'package:dictionary/presentation/styles/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "favorites".tr(),
          style: AppTextStyles.medium.copyWith(fontSize: 20.sp),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: const [],
      ),
    );
  }
}
