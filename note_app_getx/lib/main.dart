import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:note_app_getx/view/add_note_view.dart';
import 'package:note_app_getx/view/edit_note_view.dart';
import 'package:note_app_getx/view/note_details.dart';

import 'helper/bind.dart';
import 'view/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.blue));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      getPages: [
        GetPage(
            name: '/',
            page: () => const HomePage(),
            binding: NoteBind(),
            transition: Transition.zoom),
        GetPage(
            name: '/addnote',
            page: () => const AddNoteView(),
            transition: Transition.zoom),
        GetPage(
            name: '/editnote',
            page: () => EditNoteView(),
            transition: Transition.zoom),
        GetPage(
            name: '/notedetails',
            page: () => NoteDetails(),
            transition: Transition.zoom),
      ],
      initialRoute: '/',
    );
  }
}
