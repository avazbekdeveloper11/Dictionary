import 'dart:async';

import 'package:dictionary/infrastructure/models/words_model.dart';
import 'package:dictionary/infrastructure/service/hive_service.dart';
import 'package:dictionary/presentation/pages/splash_screen.dart/splash_screen.dart';
import 'package:dictionary/utils/hive_keys.dart';
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
      future: Future.wait([readJson(), readFavorites()]),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.data == null) {
          return const SplashScreen();
        } else {
          return MainPage(
            words: snapshot.data![0],
            favorites: snapshot.data![1],
          );
        }
      },
    );
  }

  Future<List<WordsModel>> readJson() async {
    List data = json.decode(
      await rootBundle.loadString('assets/translations/dictionary.json'),
    );
    return data.map((e) => WordsModel.fromJson(e)).toList();
  }

  Future<List> readFavorites() async {
    List data = await HiveService.readList(key: HiveKeys.favorites);
    return data;
  }
}
