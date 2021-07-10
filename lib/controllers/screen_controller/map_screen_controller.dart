import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/controllers/controller.dart';
import 'package:get/get.dart';

class MapScreenController extends GetxController {
  /// Location controller object
  final locationController = Get.find<LocationController>();

  /// Google map controller
  late GoogleMapController googleMapController;

  /// Current user location
  CameraPosition cameraCurrentUserPosition() {
    return CameraPosition(
      target: LatLng(
        locationController.currentLocation!.latitude!,
        locationController.currentLocation!.longitude!,
      ),
      zoom: 10.0,
    );
  }

  /// Current user location info
  Future<void> getLocation() async {
    if (locationController.currentLocation == null) {
      await locationController.getLocation();
    } else
      currentLocationAnimateCamera();
  }

  /// Update camera for current user
  Future<void> currentLocationAnimateCamera() async {
    googleMapController.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          locationController.currentLocation!.latitude!,
          locationController.currentLocation!.longitude!,
        ),
      ),
    );
  }
}
