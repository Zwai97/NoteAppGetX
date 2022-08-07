import 'package:get/get.dart';
import 'package:note_app_getx/controller/note_controller.dart';

class NoteBind extends Bindings {
  @override
  void dependencies() {
    Get.put<NoteController>(NoteController());
  }
}
