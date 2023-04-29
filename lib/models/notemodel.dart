import 'package:isar/isar.dart';

part 'notemodel.g.dart';

@collection
class NoteModel {
  Id id = Isar.autoIncrement;
  late String title, description;
  late int color;
  NoteModel(
    this.description,
    this.title,
    this.color,
  );
}
