import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testbloc/models/notemodel.dart';

class NoteDb {
  Isar? noteDB;
  NoteDb.initialise();
  static final NoteDb instace = NoteDb.initialise();
  factory NoteDb() {
    return instace;
  }

  Future<void> initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    noteDB = await Isar.open(
      [NoteModelSchema],
      directory: dir.path,
    );
  }

  Future<void> addNote(NoteModel newNote) async {
    await noteDB!.writeTxn(() async {
      await noteDB!.noteModels.put(newNote);
    });
  }

  Stream<List<NoteModel>> getNote() {
    return noteDB!.noteModels.where().watch(fireImmediately: true);
  }

  Stream<List<NoteModel>> getStaredNote() {
    return noteDB!.noteModels
        .filter()
        .isStaredActiveEqualTo(true)
        .watch(fireImmediately: true);
  }

  Future<void> delNote(Id id) async {
    await noteDB!.writeTxn(
      () async {
        await noteDB!.noteModels.delete(id);
      },
    );
  }
}
