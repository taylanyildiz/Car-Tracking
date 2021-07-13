import 'dart:convert';

import 'package:ake_car_tracker/models/car.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/services/service.dart';
import 'package:flutter/material.dart';
import '/widgets/widget.dart';
import '/controllers/controller.dart';
import 'package:get/get.dart';

class MapScreenController extends GetxController {
  @override
  void onInit() {
    getCarImeiList();
    super.onInit();
  }

  /// Car List from Restful service
  List cars = [];

  /// App bar button menu animation controller.
  ConcavAnimController menuAnimController = ConcavAnimController();

  /// Location controller object
  final locationController = Get.find<LocationController>();

  /// RestfulService object.
  final restfulService = Get.find<RestfulService>();

  final mqttService = Get.find<MqttService>();

  /// Google map controller
  late GoogleMapController googleMapController;

  /// Current user location
  cameraCurrentUserPosition() {
    return CameraPosition(
      target: locationController.currentLocation != null
          ? LatLng(
              locationController.currentLocation!.latitude!,
              locationController.currentLocation!.longitude!,
            )
          : LatLng(38.7574212, 26.1707787),
      zoom: 11.5,
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

  /// Parse receive message form mqtt. [imei/data]
  void parseMqttDataSensor(imei, message) {
    List result = jsonDecode(message);
    int carIndex = cars.indexWhere((element) => element.imei == imei);
    if (carIndex != -1) {
      result.forEach((element) {
        print(element);
      });
    }
  }

  /// Click menu button
  void onMenu() {
    menuAnimController.onAnim();
  }

  /// Click gps button
  void onGpsFixed() async {
    await currentLocationAnimateCamera();
  }

  void getCarImeiList() async {
    cars = (await restfulService.getCars()) ?? [];
    for (Car c in cars) {
      mqttService.subscribeAllTopic(c.imei.toString());
    }
  }
}
