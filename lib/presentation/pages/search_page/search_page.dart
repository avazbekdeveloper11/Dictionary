import 'package:dictionary/presentation/components/text_filed_component.dart';
import 'package:dictionary/presentation/styles/app_colors.dart';
import 'package:dictionary/presentation/styles/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          splashRadius: 20.r,
          onPressed: () => Navigator.pop(context),
        ),
        title: TextFieldComponent(
          hint: "search".tr(),
          onChanged: (v) {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            splashRadius: 20.r,
            onPressed: () {},
          ),
        ],
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: ListTile(
              tileColor: AppColors.white,
              title: Text(
                "RU",
                style: AppTextStyles.medium.copyWith(
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "UZ",
                style: AppTextStyles.regular.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.disabledTextColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
