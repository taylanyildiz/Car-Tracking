import '/controllers/controller.dart';
import 'package:get/instance_manager.dart';

class CarDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CarDetailScreenController());
  }
}
