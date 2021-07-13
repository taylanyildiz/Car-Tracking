class Sensor {
  Sensor({
    required this.dataKey,
    required this.dataValue,
  });

  String? dataKey;
  String? dataValue;
  String? sensorValue;

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      dataKey: json['dataKey'],
      dataValue: json['dataValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dataKey': dataKey,
      'dataValue': dataValue,
    };
  }
}
