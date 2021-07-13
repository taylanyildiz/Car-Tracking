import 'package:ake_car_tracker/models/sensor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Car {
  Car({
    this.imei,
    this.sensors,
  });

  String? imei;
  LatLng? latLng;
  double? rotation = 0;
  List<Sensor>? sensors;

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      imei: json['imei'],
      sensors:
          List<Sensor>.from(json['sensors'].map((e) => Sensor.fromJson(e))),
    );
  }
}
