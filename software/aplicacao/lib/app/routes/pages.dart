import 'package:get/get.dart';

import '../modules/bottom_navigation/bottom_navigation_controller.dart';
import '../modules/bottom_navigation/bottom_navigation_page.dart';
import '../modules/home/home_controller.dart';
import '../modules/plant/plant_controller.dart';
import '../modules/plant/plant_page.dart';

List<GetPage> getAppPages() {
  return [
    GetPage(
      name: BottomNavigationPage.route,
      page: () => const BottomNavigationPage(),
      bindings: [
        BindingsBuilder(() => Get.lazyPut<BottomNavigationController>(() => BottomNavigationController())),
        BindingsBuilder(() => Get.lazyPut<HomeController>(() => HomeController())),
      ],
    ),
    GetPage(
      name: PlantPage.route,
      page: () => const PlantPage(),
      binding: BindingsBuilder(() => Get.lazyPut<PlantController>(() => PlantController())),
    )
  ];
}
