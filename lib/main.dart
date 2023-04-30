import 'package:flutter/material.dart';
import 'package:testbloc/db/notedb.dart';
import 'package:testbloc/screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (NoteDb.instace.noteDB == null) {
    await NoteDb.instace.initDb();
  }
  runApp(
    MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(0),
          filled: true,
          fillColor: Colors.white.withOpacity(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    ),
  );
}
