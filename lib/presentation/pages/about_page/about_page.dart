import 'package:dictionary/presentation/styles/app_colors.dart';
import 'package:dictionary/presentation/styles/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 100.w),
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: AppColors.primaryColor,
                    child: const Icon(Icons.keyboard_backspace_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            CircleAvatar(
              radius: 80.r,
              backgroundImage:
                  const AssetImage("assets/pictures/developer.jpg"),
            ),
            SizedBox(height: 12.h),
            Text(
              "nameAndSurName".tr(),
              style: AppTextStyles.medium.copyWith(
                fontSize: 26.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(size: 40),
                SizedBox(width: 8.w),
                Text(
                  "flutterDeveloper".tr(),
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 32.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              "about_text".tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.regular.copyWith(
                fontSize: 20.sp,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myProfile(
                  image: "assets/svg/telegram.svg",
                  name: "telegram".tr(),
                  uri: 'https://t.me/mavlonov_avazbek',
                ),
                SizedBox(width: 20.w),
                myProfile(
                  image: "assets/svg/instagram.svg",
                  name: "instagram".tr(),
                  uri: 'https://www.instagram.com/mavlonov_2003_',
                )
              ],
            ),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }

  GestureDetector myProfile({
    required String image,
    required String name,
    required String uri,
  }) {
    return GestureDetector(
      onTap: () => geturl(uri),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              image,
              height: 40,
              width: 40,
            ),
            SizedBox(width: 8.h),
            Text(
              name,
              style: AppTextStyles.medium.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> geturl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
