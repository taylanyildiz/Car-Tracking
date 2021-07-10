import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslateHelper {
  TranslateHelper._();

  static updateLocale(Locale locale) {
    Get.updateLocale(locale);
  }

  static String get information => 'information'.tr;
  static String get status => 'status'.tr;
  static String get search => 'search'.tr;
  static String get cars => 'cars'.tr;
  static String get map => 'map'.tr;
  static String get profile => 'profile'.tr;
  static String get users => 'users'.tr;
}
