import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dictionary/presentation/styles/app_colors.dart';

class DialogComponent extends StatelessWidget {
  final String bodyText;
  final String buttonText;
  final VoidCallback onPressed;

  const DialogComponent({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    required this.bodyText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r)), //this right here
      child: SizedBox(
        height: 200.h,
        width: 315.w,
        child: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                bodyText,
                textAlign: TextAlign.center,
                style: AdaptiveTheme.of(context).theme.textTheme.headline3,
              ),
              SizedBox(height: 34.h),
              GestureDetector(
                onTap: onPressed,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 82.w),
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.primaryColor)),
                  child: Center(
                    child: Text(
                      buttonText,
                      style:
                          AdaptiveTheme.of(context).theme.textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
