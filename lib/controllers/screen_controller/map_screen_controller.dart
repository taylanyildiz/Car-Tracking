import 'package:flutter/material.dart';

import '/widgets/widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/controllers/controller.dart';
import 'package:get/get.dart';

class MapScreenController extends GetxController {
  /// App bar button menu animation controller.
  ConcavAnimController menuAnimController = ConcavAnimController();

  /// App bar button gps fixed animation controler.
  ConcavAnimController gpsFixedController = ConcavAnimController();

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

  /// Change Map style to Dark mode
  Future<void> changeMapStyle() async {
    var mapStyle = await DefaultAssetBundle.of(Get.context!)
        .loadString('assets/json/map_theme.json');
    googleMapController.setMapStyle(mapStyle);
  }

  /// Click menu button
  void onMenu() {
    menuAnimController.onAnim();
  }

  /// Click gps button
  void onGpsFixed() {
    gpsFixedController.onAnim();
  }
}
