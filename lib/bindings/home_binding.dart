import '/services/service.dart';
import '/controllers/controller.dart';
import 'package:get/instance_manager.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
    Get.put(MqttService());
  }
}
