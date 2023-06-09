import 'package:isar/isar.dart';

part 'notemodel.g.dart';

@collection
class NoteModel {
  Id id = Isar.autoIncrement;
  late String title, description;
  late int color;
  bool isStaredActive;
  DateTime dateTime;
  NoteModel(
    this.description,
    this.title,
    this.color,
    this.isStaredActive,
    this.dateTime,
  );
}
