import 'package:dictionary/presentation/pages/about_page/about_page.dart';
import 'package:dictionary/presentation/pages/app_widget.dart';
import 'package:dictionary/presentation/pages/favorites_page/favorites_page.dart';
import 'package:dictionary/presentation/pages/search_page/search_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  const AppRoutes._();

  static MaterialPageRoute appWidget() {
    return MaterialPageRoute(
      builder: (_) => const AppWidget(),
    );
  }

  static MaterialPageRoute searchPage() {
    return MaterialPageRoute(
      builder: (_) => const SearchPage(),
    );
  }

  static MaterialPageRoute favoritesPage() {
    return MaterialPageRoute(
      builder: (_) => const FavoritesPage(),
    );
  }

  static MaterialPageRoute aboutPage() {
    return MaterialPageRoute(
      builder: (_) => const AboutPage(),
    );
  }
}
