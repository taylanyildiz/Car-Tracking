import '/bindings/binding.dart';
import '/routers/page_routers.dart';
import '/screens/screen.dart';
import 'package:get/route_manager.dart';

class Pages {
  Pages._();

  static final List<GetPage> pages = [
    GetPage(
      name: PageRouters.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: PageRouters.CAR_DETAIL,
      page: () => CarDetailScreen(),
      binding: CarDetailBinding(),
    ),
    GetPage(
      name: PageRouters.MAP,
      page: () => MapScreen(),
      binding: MappBinding(),
    ),
  ];
}
