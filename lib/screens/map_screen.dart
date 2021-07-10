import 'package:ake_car_tracker/widgets/widget.dart';

import '/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends GetView<MapScreenController> {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapScreenController>(
      builder: (_) => Scaffold(
        body: Stack(
          children: [
            _buildGoogleMap(),
            _buildAppBar(),
            _buildBottomSheet(),
          ],
        ),
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
        controller.changeMapStyle();
      },
    );
  }

  _buildAppBar() {
    return Positioned(
      top: 40.0,
      left: 20.0,
      right: 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleConcavButton(
            onPressed: controller.onMenu,
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            animChild: Icon(
              Icons.close,
              color: Colors.white,
            ),
            animController: controller.menuAnimController,
          ),
          CircleConcavButton(
            autoReverse: true,
            onPressed: controller.onGpsFixed,
            child: Icon(
              Icons.gps_fixed,
              color: Colors.white,
            ),
            animChild: Icon(
              Icons.gps_fixed,
              color: Colors.blue,
            ),
            animController: controller.gpsFixedController,
          )
        ],
      ),
    );
  }

  _buildBottomSheet() {
    return CustomBottomSheet(
      minHeight: 100.0,
      maxHeight: 200.0,
      header: Row(
        children: [],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
