import 'package:ake_car_tracker/constants/resful_constant.dart';
import 'package:ake_car_tracker/models/car.dart';
import 'package:get/get_connect.dart';

class RestfulService extends GetConnect {
  @override
  void onInit() async {
    httpClient.baseUrl = ResftulConstant.BASE_URL;
    super.onInit();
  }

  Future getCars() async {
    String url = ResftulConstant.CAR_ROUTER + ResftulConstant.CAR_IMEIS;
    Response response = await get(url);
    if (response.statusCode == 200) {
      return response.body['cars'].map((e) => Car.fromJson(e)).toList();
    }
  }
}
