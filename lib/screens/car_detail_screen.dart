import 'package:ake_car_tracker/localization/translate_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Stack(
          children: [
            _buildTopBackandProfileButton(),
            _buildandSelectName(),
            _buildVehicleImage(),
            _buildVehicleStatus(),
            _buildBottomSheet(),
          ],
        ),
      ),
    );
  }

  _buildTopBackandProfileButton() {
    return Positioned(
      top: Get.height * .055,
      right: Get.width * .05,
      left: Get.width * .05,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleConcavButton(
              onPressed: () => Get.back(),
              child: Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
              ),
            ),
            CircleConcavButton(
              onPressed: () {},
              child: Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildandSelectName() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      top: Get.height * .058,
      child: Column(
        children: [
          Text(
            'Ake',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'Range Rover',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _buildVehicleImage() {
    return Positioned(
      top: Get.height * .22,
      left: 40.0,
      right: 40.0,
      child: Hero(
        tag: 'car',
        child: Image.asset(
          'assets/images/top_side_car.png',
        ),
      ),
    );
  }

  _buildVehicleStatus() {
    return Positioned(
      top: Get.height * .5,
      left: 40.0,
      right: 40.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TranslateHelper.status,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatusInfo(
                title: 'Battery',
                value: '54%',
                icon: Icons.battery_full,
              ),
              _StatusInfo(
                title: 'Range',
                value: '297 km',
                icon: Icons.near_me,
              ),
              _StatusInfo(
                title: 'Temperture',
                value: '27 °C',
                icon: Icons.thermostat,
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildBottomSheet() {
    return CustomBottomSheet(
      minHeight: 130.0,
      maxHeight: 600.0,
      header: Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 10.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A/C is ON',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Tap to turn off or swipe up\nfor a fast setup',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            right: 10.0,
            child: CircleConvexButton(
              padding: 40.0,
              onPressed: () {},
              color: Colors.white,
              child: Icon(
                FontAwesomeIcons.powerOff,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

class _StatusInfo extends StatelessWidget {
  _StatusInfo({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey, size: 16.0),
        SizedBox(width: 5.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}
