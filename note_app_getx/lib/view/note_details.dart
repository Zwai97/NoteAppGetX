import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_getx/controller/note_controller.dart';

class NoteDetails extends GetView<NoteController> {
  NoteDetails({Key? key}) : super(key: key);
  int x = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Get.toNamed('/editnote', arguments: x),
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Get.bottomSheet(
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: "DeleteAllNotes",
                                  middleText:
                                      'Are you sure you want to delete the note?',
                                  cancel: TextButton(
                                      onPressed: () => Get.back(),
                                      child: const Text('No')),
                                  confirm: TextButton(
                                      onPressed: () {
                                        controller.deleteNote(
                                            controller.notes[x].id!);
                                        Get.offAllNamed('/homepage');
                                      },
                                      child: const Text('Yes')));
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.delete),
                                SizedBox(width: 5),
                                Text('Delete')
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.shareNote(controller.notes[x].title!,
                                  controller.notes[x].content!);
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.share),
                                SizedBox(width: 5),
                                Text('Share')
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Created: ${controller.notes[Get.arguments].dateTimeCreated}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Content Word Count: ${controller.contentWordCount}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Content Char Count: ${controller.contentCharCount}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 40),
                          const Center(
                            child: Text(
                              'Created by Amjed Roumani',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                );
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                '${controller.notes[Get.arguments].title}',
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 15),
              Text('${controller.notes[Get.arguments].content}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  )),
              const SizedBox(height: 15),
              Text(
                  'LastEdited:  ${controller.notes[Get.arguments].dateTimeEdited}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
