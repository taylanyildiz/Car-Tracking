import 'dart:developer';
import 'package:get/get_connect.dart';

class RestfulService extends GetConnect {
  @override
  void onInit() async {
    httpClient.baseUrl = 'http://213.238.180.11:3350/api/v1';
    await getAdress();
    super.onInit();
  }

  Future getAdress() async {
    String url = '/adress/get-all-adress';
    Response response = await get(url);
    log(response.body.toString());
    List e = response.body.map((e) => Adress.fromJson(e)).toList();
    print('');
    for (Adress a in e) {
      print(a.adress_city);
    }
  }
}

class Adress {
  Adress({
    required this.adress_id,
    required this.adress_country,
    required this.adress_state,
    required this.adress_city,
    required this.adress_street,
  });

  int? adress_id;
  String? adress_country;
  String? adress_state;
  String? adress_city;
  String? adress_street;

  factory Adress.fromJson(Map<String, dynamic> json) {
    return Adress(
      adress_id: json['adress_id'],
      adress_country: json['adress_country'],
      adress_state: json['adress_state'],
      adress_city: json['adress_city'],
      adress_street: json['adress_street'],
    );
  }
}
