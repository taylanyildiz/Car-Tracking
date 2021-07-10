import 'package:ake_car_tracker/localization/languages/en.dart';
import 'package:ake_car_tracker/localization/languages/tr.dart';
import 'package:get/route_manager.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'tr': tr,
      };
}
