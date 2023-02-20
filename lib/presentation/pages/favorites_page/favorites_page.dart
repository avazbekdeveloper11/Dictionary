import 'package:dictionary/infrastructure/models/words_model.dart';
import 'package:dictionary/infrastructure/service/hive_service.dart';
import 'package:dictionary/presentation/components/dialog_component.dart';
import 'package:dictionary/presentation/styles/app_colors.dart';
import 'package:dictionary/presentation/styles/app_styles.dart';
import 'package:dictionary/utils/hive_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "favorites".tr(),
            style: AppTextStyles.medium.copyWith(fontSize: 20.sp),
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 60),
            child: TabBar(
              onTap: (v) => setState(() {}),
              indicatorWeight: 5,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: AppColors.white,
              controller: tabController,
              tabs: [
                Tab(
                  icon: Text(
                    "ENGLISH-UZBEK",
                    style: AppTextStyles.medium.copyWith(fontSize: 14.sp),
                  ),
                ),
                Tab(
                  icon: Text(
                    "UZBEK-ENGLISH",
                    style: AppTextStyles.medium.copyWith(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          elevation: 0,
        ),
        body: FutureBuilder<List>(
          future: HiveService.readList(key: HiveKeys.favorites),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List model = snapshot.data ?? [];
              return Scrollbar(
                thickness: 8,
                interactive: true,
                thumbVisibility: true,
                radius: const Radius.circular(8),
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    String uzbek = tabController.index == 1
                        ? model[index].uzbek
                        : model[index].english;
                    String english = tabController.index == 1
                        ? model[index].english
                        : model[index].uzbek;
                    return ListTile(
                      trailing: IconButton(
                        splashRadius: 20.r,
                        icon: Icon(
                          Icons.star_rate_rounded,
                          color: Colors.yellowAccent,
                          size: 28.sp,
                        ),
                        onPressed: () {
                          HiveService.removeList(
                            key: HiveKeys.favorites,
                            value: model[index],
                          );
                          setState(() {});
                        },
                      ),
                      onTap: () => DialogComponent.showdialog(
                        ctx: context,
                        title: uzbek,
                        subtitle: english,
                      ),
                      title: Text(
                        uzbek,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 18.sp,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        english,
                        style: AppTextStyles.regular.copyWith(
                          fontSize: 18.sp,
                          color: AppColors.disabledTextColor,
                        ),
                      ),
                    );
                  },
                  prototypeItem: ListTile(
                    title: Text(
                      "",
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "",
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.disabledTextColor,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
