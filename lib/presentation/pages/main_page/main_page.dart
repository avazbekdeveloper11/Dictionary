import 'package:dictionary/infrastructure/service/hive_service.dart';
import 'package:dictionary/presentation/components/dialog_component.dart';
import 'package:dictionary/presentation/components/text_filed_component.dart';
import 'package:dictionary/presentation/routes/routes.dart';
import 'package:dictionary/presentation/styles/app_colors.dart';
import 'package:dictionary/presentation/styles/app_icons.dart';
import 'package:dictionary/presentation/styles/app_styles.dart';
import 'package:dictionary/utils/hive_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MainPage extends StatefulWidget {
  final List words;
  final List favorites;
  const MainPage({super.key, required this.words, required this.favorites});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  late TabController tabController;
  late TextEditingController _searchController;
  bool isSearch = false;
  bool showbtn = false;
  List items = [];

  @override
  void initState() {
    scrollController.addListener(() {
      double showoffset = 10.0;
      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {});
      } else {
        showbtn = false;
        setState(() {});
      }
    });
    _searchController = TextEditingController();
    tabController = TabController(length: 2, vsync: this);
    items.addAll(widget.words);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _scaffoldKey.currentState?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      // ! APPBAR
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20.r,
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: SvgPicture.asset(AppIcons.drawer),
        ),
        title: isSearch
            ? TextFieldComponent(
                textEditingController: _searchController,
                hint: "search".tr(),
                onChanged: (v) => filterSearchResults(v),
              )
            : Text(
                "dictionary".tr(),
                style: AppTextStyles.medium.copyWith(fontSize: 20.sp),
              ),
        actions: [
          isSearch
              ? IconButton(
                  splashRadius: 20.r,
                  onPressed: () {
                    items.clear();
                    _searchController.clear();
                    items.addAll(widget.words);
                    setState(() => isSearch = !isSearch);
                  },
                  icon: const Icon(Icons.close),
                )
              : IconButton(
                  splashRadius: 20.r,
                  icon: SvgPicture.asset(AppIcons.search),
                  onPressed: () => setState(() => isSearch = !isSearch),
                ),
        ],
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: TabBar(
            indicatorWeight: 5,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppColors.white,
            controller: tabController,
            onTap: (v) => setState(
              () {
                filterSearchResults(_searchController.text);
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
              },
            ),
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
      ),
      // ! DRAWER
      drawer: Container(
        color: AppColors.white,
        width: 300.w,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primaryColor),
              currentAccountPicture: const CircleAvatar(
                backgroundImage:
                    AssetImage("assets/pictures/dictionary_book.jpg"),
              ),
              accountEmail: Text(
                "dictionary".tr(),
                style: AppTextStyles.medium.copyWith(fontSize: 20.sp),
              ),
              accountName: const Text(""),
            ),
            drawerTile(
              icons: Icons.sentiment_satisfied_alt,
              text: "rating".tr(),
            ),
            drawerTile(
              icons: Icons.star_border_rounded,
              text: "favorites".tr(),
              onTap: () => Navigator.push(
                context,
                AppRoutes.favoritesPage(),
              ),
            ),
            drawerTile(
              icons: Icons.share,
              text: "share".tr(),
            ),
            drawerTile(
              icons: Icons.info_outline,
              text: "about".tr(),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, AppRoutes.aboutPage());
              },
            ),
            drawerTile(
              icons: Icons.exit_to_app_rounded,
              text: "exit".tr(),
              onTap: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
        ),
      ),
      // ! BODY
      body: Scrollbar(
        controller: scrollController,
        thickness: 8,
        interactive: true,
        thumbVisibility: true,
        radius: const Radius.circular(8),
        child: ListView.builder(
          controller: scrollController,
          itemCount: items.length,
          itemBuilder: (context, index) {
            String uzbek = tabController.index == 1
                ? items[index].uzbek
                : items[index].english;
            String english = tabController.index == 1
                ? items[index].english
                : items[index].uzbek;
            if (widget.favorites.map((e) => e.id).contains(items[index].id)) {
              return wordTile(
                index,
                context,
                uzbek,
                english,
                true,
              );
            } else {
              return wordTile(
                index,
                context,
                uzbek,
                english,
              );
            }
          },
          prototypeItem: wordTile(
            0,
            context,
            "",
            "",
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: showbtn ? 1.0 : 0.0,
        child: FloatingActionButton(
          onPressed: () => scrollController.animateTo(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn),
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.arrow_upward),
        ),
      ),
    );
  }

  Padding wordTile(
      int index, BuildContext context, String uzbek, String english,
      [bool isSaved = false]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: ListTile(
        tileColor: AppColors.white,
        trailing: IconButton(
          splashRadius: 20.r,
          icon: isSaved
              ? Icon(
                  Icons.star_rate_rounded,
                  color: Colors.yellowAccent,
                  size: 28.sp,
                )
              : Icon(
                  Icons.star_border_rounded,
                  size: 28.sp,
                ),
          onPressed: () {
            if (!isSaved) {
              HiveService.writeList(
                key: HiveKeys.favorites,
                value: items[index],
              );
            } else {
              HiveService.removeList(
                key: HiveKeys.favorites,
                value: items[index],
              );
              for (var i = 0; i < widget.favorites.length; i++) {
                if (widget.favorites[i].id == items[index].id) {
                  widget.favorites.removeAt(i);
                }
              }
            }
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
      ),
    );
  }

  void showInSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        content: Text(text),
      ),
    );
  }

  void filterSearchResults(String query) {
    List dummySearchList = [];
    dummySearchList.addAll(widget.words);
    if (query.isNotEmpty) {
      List dummyListData = [];
      for (var item in dummySearchList) {
        if ((tabController.index == 0 ? item.english : item.uzbek)
            .contains(query)) {
          dummyListData.add(item);
          if (dummyListData.length == 100) break;
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(
        () {
          items.clear();
          items.addAll(widget.words);
        },
      );
    }
  }

  ListTile drawerTile({
    required String text,
    required IconData icons,
    Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icons,
        color: Colors.black,
        size: 26.sp,
      ),
      title: Text(
        text,
        style: AppTextStyles.medium.copyWith(color: Colors.black),
      ),
    );
  }
}
