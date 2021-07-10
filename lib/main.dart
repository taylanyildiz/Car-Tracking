import 'package:ake_car_tracker/bindings/home_binding.dart';
import 'package:ake_car_tracker/localization/localization.dart';

import '/routers/pages.dart';
import '/routers/page_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ake Vehicle Tracking',
      initialRoute: PageRouters.HOME,
      initialBinding: HomeBinding(),
      locale: Get.locale ?? Locale('en'),
      translations: Localization(),
      getPages: Pages.pages,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
