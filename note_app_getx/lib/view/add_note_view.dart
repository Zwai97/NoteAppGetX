import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_getx/controller/note_controller.dart';

class AddNoteView extends GetView<NoteController> {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Note',
        ),
        elevation: 5,
        // shape:
        // RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: controller.titlecontroller,
                style: const TextStyle(fontSize: 22),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                        letterSpacing: 1)),
              ),
              TextField(
                controller: controller.contentcontroller,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Content',
                  hintStyle: TextStyle(
                    fontSize: 22,
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addNote(),
        child: const Icon(Icons.check),
      ),
    );
  }
}
