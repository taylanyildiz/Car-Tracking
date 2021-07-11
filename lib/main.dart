import 'package:ake_car_tracker/services/service.dart';

import '/bindings/home_binding.dart';
import '/localization/localization.dart';
import '/routers/pages.dart';
import '/routers/page_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LocationController());
  Get.put(RestfulService());
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
