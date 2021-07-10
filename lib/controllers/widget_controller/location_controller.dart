import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  late bool isServiceEnable;
  PermissionStatus? isPermissionGrant;
  Location location = new Location();
  LocationData? currentLocation;

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }

  Future<LocationData?>? getLocation() async {
    isServiceEnable = await location.serviceEnabled();
    if (!isServiceEnable)
      isServiceEnable = await location.requestService();
    else
      return null;

    isPermissionGrant = await location.hasPermission();
    if (isPermissionGrant == PermissionStatus.denied) {
      isPermissionGrant = await location.requestPermission();
      if (isPermissionGrant != PermissionStatus.granted) return null;
    }
    currentLocation = await location.getLocation();
    update();
    return currentLocation;
  }
}
