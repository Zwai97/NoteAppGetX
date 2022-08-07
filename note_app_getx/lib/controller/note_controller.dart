import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';

import '../helper/database.dart';
import '../model/note.dart';

class NoteController extends GetxController {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController contentcontroller = TextEditingController();

  int contentWordCount = 0;
  int contentCharCount = 0;

  List<Note> notes = [];

  bool isEmpty() {
    if (notes.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void getAllNotes() async {
    notes = await DatabaseHelper.instance.getAllNotes();
    update();
  }

  void addNote() async {
    String? title = titlecontroller.text;
    String? content = contentcontroller.text;
    if (title.isEmpty) {
      title = 'UnNamed';
    }
    Note note = Note(
        content: content,
        title: title,
        dateTimeCreated:
            DateFormat("MMM dd, yyyy  HH:mm:ss").format(DateTime.now()),
        dateTimeEdited:
            DateFormat("MMM dd, yyyy  HH:mm:ss").format(DateTime.now()));
    await DatabaseHelper.instance.addNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titlecontroller.text = '';
    contentcontroller.text = '';
    getAllNotes();
    Get.back();
  }

  void updateNote(int id, String dTCreated) async {
    String? title = titlecontroller.text;
    String? content = contentcontroller.text;
    Note note = Note(
        id: id,
        title: title,
        content: content,
        dateTimeEdited:
            DateFormat("MMM dd, yyyy  HH:mm:ss").format(DateTime.now()),
        dateTimeCreated: dTCreated);
    await DatabaseHelper.instance.updateNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titlecontroller.text = '';
    contentcontroller.text = '';
    getAllNotes();
    Get.back();
  }

  void deleteNote(int id) async {
    Note note = Note(id: id);
    await DatabaseHelper.instance.deleteNote(note);
    getAllNotes();
  }

  void deleteAllNotes() async {
    await DatabaseHelper.instance.deleteAllNotes();
    getAllNotes();
  }

  void shareNote(String title, String content) {
    Share.share("$title \n$content");
  }

  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }
}
