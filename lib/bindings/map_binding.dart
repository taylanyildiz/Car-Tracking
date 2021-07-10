import '/controllers/controller.dart';
import 'package:get/instance_manager.dart';

class MappBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MapScreenController());
  }
}
