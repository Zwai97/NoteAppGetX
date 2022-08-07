import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_getx/controller/note_controller.dart';

import '../widget/search_bar.dart';

class HomePage extends GetView<NoteController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: SearchBar()),
              icon: const Icon(Icons.search)),
          PopupMenuButton(
              onSelected: (val) {
                if (val == 0) {
                  Get.defaultDialog(
                      title: "DeleteAllNotes",
                      middleText: 'Are you sure you want to delete all notes?',
                      cancel: TextButton(
                          onPressed: () => Get.back(), child: const Text('No')),
                      confirm: TextButton(
                          onPressed: () {
                            controller.deleteAllNotes();
                            Get.back();
                          },
                          child: const Text('Yes')));
                }
              },
              itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 0,
                      child: Text(
                        'Delete All Notes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ])
        ],
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        elevation: 5,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
        ),
      ),
      body: GetBuilder<NoteController>(
        builder: (controller) =>
            controller.isEmpty() ? emptyNotes() : viewNotes(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/addnote'),
        backgroundColor: Get.theme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget emptyNotes() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/note.json'),
            const SizedBox(height: 60),
            Text(
              'You Don\'t Have Any Notes',
              style: TextStyle(
                color: Colors.black,
                fontSize: Get.theme.textTheme.headline5!.fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget viewNotes() {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: StaggeredGridView.countBuilder(
        itemCount: controller.notes.length,
        crossAxisCount: 2,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 20.0,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.toNamed('notedetails', arguments: index),
            onLongPress: () {
              Get.defaultDialog(
                  title: "DeleteAllNotes",
                  middleText: 'Are you sure you want to delete the note?',
                  cancel: TextButton(
                      onPressed: () => Get.back(), child: const Text('No')),
                  confirm: TextButton(
                      onPressed: () {
                        controller.deleteNote(controller.notes[index].id!);
                        Get.back();
                      },
                      child: const Text('Yes')));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //todo add note(title) from index
                    controller.notes[index].title!,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    //todo add note(content) from index
                    controller.notes[index].content!,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    //todo add note(date time) from index
                    controller.notes[index].dateTimeEdited!,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
