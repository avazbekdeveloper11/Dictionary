// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'words_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordsModelAdapter extends TypeAdapter<WordsModel> {
  @override
  final int typeId = 1;

  @override
  WordsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordsModel(
      id: fields[1] as String,
      english: fields[2] as String,
      type: fields[3] as String,
      transcript: fields[4] as String,
      uzbek: fields[5] as String,
      countable: fields[6] as String,
      isFavourite: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WordsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.english)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.transcript)
      ..writeByte(5)
      ..write(obj.uzbek)
      ..writeByte(6)
      ..write(obj.countable)
      ..writeByte(7)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
