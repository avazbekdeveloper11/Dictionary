import 'dart:async';

import 'package:dictionary/presentation/pages/splash_screen.dart/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main_page/main_page.dart';
import 'dart:convert';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: readJson(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const SplashScreen();
        } else {
          return MainPage(words: snapshot.data!);
        }
      },
    );
  }

  Future<List> readJson() async {
    await Future.delayed(const Duration(seconds: 1));
    return json.decode(
      await rootBundle.loadString('assets/translations/dictionary.json'),
    );
  }
}
