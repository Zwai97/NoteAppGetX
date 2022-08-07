import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_getx/controller/note_controller.dart';

class SearchBar extends SearchDelegate {
  final NoteController controller = Get.find<NoteController>();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Get.back(),
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? controller.notes
        : controller.notes.where((e) {
            return e.title!.toLowerCase().contains(query.toLowerCase()) ||
                e.content!.toLowerCase().contains(query.toLowerCase());
          }).toList();

    return const Text('data');
  }
}
