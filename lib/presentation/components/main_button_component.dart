import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dictionary/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButtonComponent extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final EdgeInsets? margin;

  const MainButtonComponent({
    Key? key,
    required this.onPressed,
    required this.text,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin,
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            text,
            style: AdaptiveTheme.of(context).theme.textTheme.button,
          ),
        ),
      ),
    );
  }
}
