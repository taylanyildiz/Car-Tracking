import 'package:get/get.dart';
import 'package:lacation/location.dart';

class LocationController extends GetxController {
  late bool isServiceEnable;
  PermissionStatus? isPermissionGrant;
  Location location = new Location();
  LocationData? currentLocation;
}
