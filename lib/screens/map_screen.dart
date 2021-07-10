import '/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends GetView<MapScreenController> {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(),
        ],
      ),
    );
  }

  GoogleMap _buildGoogleMap() {
    return GoogleMap(
      initialCameraPosition: controller.cameraCurrentUserPosition(),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: (googleMapController) {
        controller.googleMapController = googleMapController;
      },
    );
  }
}
