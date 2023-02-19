import 'package:dictionary/presentation/components/text_filed_component.dart';
import 'package:dictionary/presentation/routes/routes.dart';
import 'package:dictionary/presentation/styles/app_colors.dart';
import 'package:dictionary/presentation/styles/app_icons.dart';
import 'package:dictionary/presentation/styles/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MainPage extends StatefulWidget {
  final List words;
  const MainPage({super.key, required this.words});

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
              icon: const Icon(
                Icons.sentiment_satisfied_alt,
                color: Colors.black,
              ),
              text: "rating".tr(),
            ),
            drawerTile(
              icon: const Icon(Icons.favorite_border, color: Colors.black),
              text: "favorites".tr(),
              onTap: () => Navigator.push(
                context,
                AppRoutes.favoritesPage(),
              ),
            ),
            drawerTile(
              icon: const Icon(Icons.share, color: Colors.black),
              text: "share".tr(),
            ),
            drawerTile(
              icon: const Icon(Icons.info_outline, color: Colors.black),
              text: "about".tr(),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, AppRoutes.aboutPage());
              },
            ),
            drawerTile(
              icon: const Icon(Icons.exit_to_app_rounded, color: Colors.black),
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
            return ListTile(
              onTap: () => showdialog(
                  ctx: context,
                  title: items[index]
                      [tabController.index == 1 ? 'uzbek' : 'english'],
                  subtitle: items[index]
                      [tabController.index == 1 ? 'english' : 'uzbek']),
              title: Text(
                items[index][tabController.index == 1 ? 'uzbek' : 'english'],
                style: AppTextStyles.medium.copyWith(
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                items[index][tabController.index == 1 ? 'english' : 'uzbek'],
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
        if (item[tabController.index == 0 ? 'english' : 'uzbek']
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

  ListTile drawerTile(
      {required String text, required var icon, Function()? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(
        text,
        style: AppTextStyles.medium.copyWith(color: Colors.black),
      ),
    );
  }

  Future showdialog({
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
