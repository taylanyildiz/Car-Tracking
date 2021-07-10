import 'package:ake_car_tracker/localization/translate_helper.dart';
import '/routers/page_routers.dart';
import '/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  /// Search Input controller for animation.
  SearchAnimController searchAnimController = SearchAnimController();

  /// Serch button controller for animation.
  ConcavAnimController concavAnimController = ConcavAnimController();

  /// Click search button.
  void onSearch() {
    searchAnimController.search();
    concavAnimController.onAnim();
  }

  /// Search change
  void onSearchChange(String? input) {
    print(input);
  }

  /// Info Card List headers.
  var infoCardHeader = <String>[
    TranslateHelper.map,
    TranslateHelper.cars,
    TranslateHelper.users,
    TranslateHelper.profile,
  ];

  /// Info Card Hedaer Icons.
  final infoCardHeaderIcon = [
    FontAwesomeIcons.map,
    FontAwesomeIcons.car,
    FontAwesomeIcons.user,
    Icons.manage_accounts,
  ];

  /// Click on card info
  void onCardInfo(int index) {
    switch (index) {
      case 0:
        Get.toNamed(PageRouters.MAP);
        break;
      case 1:
        Get.toNamed(PageRouters.CAR_DETAIL);
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }
}
