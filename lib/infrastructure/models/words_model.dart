import 'package:hive/hive.dart';
import 'dart:convert';

part 'words_model.g.dart';

List<WordsModel> wordsModelFromJson(String str) => List<WordsModel>.from(json.decode(str).map((x) => WordsModel.fromJson(x)));

String wordsModelToJson(List<WordsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class WordsModel {
    WordsModel({
        required this.id,
        required this.english,
        required this.type,
        required this.transcript,
        required this.uzbek,
        required this.countable,
        required this.isFavourite,
    });

    @HiveField(1)
    String id;
    @HiveField(2)
    String english;
    @HiveField(3)
    String type;
    @HiveField(4)
    String transcript;
    @HiveField(5)
    String uzbek;
    @HiveField(6)
    String countable;
    @HiveField(7)
    String isFavourite;

    factory WordsModel.fromJson(Map<String, dynamic> json) => WordsModel(
        id: json["id"],
        english: json["english"],
        type: json["type"],
        transcript: json["transcript"],
        uzbek: json["uzbek"],
        countable: json["countable"],
        isFavourite: json["is_favourite"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "english": english,
        "type": type,
        "transcript": transcript,
        "uzbek": uzbek,
        "countable": countable,
        "is_favourite": isFavourite,
    };
}
