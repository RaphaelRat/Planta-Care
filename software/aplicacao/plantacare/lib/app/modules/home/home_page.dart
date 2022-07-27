import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../bottom_navigation/bottom_navigation_controller.dart';
import '../plant/plant_page.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Image.asset('assets/img/Avatar.png'),
                    onTap: () => Get.find<BottomNavigationController>()
                        .pageController
                        .animateToPage(2, duration: const Duration(milliseconds: 500), curve: Curves.ease),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.color2,
                        border: Border.all(color: AppColors.color2),
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20))),
                    child: Row(
                      children: const [
                        Icon(Icons.notifications_none_rounded),
                        SizedBox(width: 8),
                        Icon(Icons.settings_outlined),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Olá, Bruno',
                style: TextStyle(color: AppColors.color3, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 6),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Já conferiu suas plantas hoje?',
                style: TextStyle(color: AppColors.color4, fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: MediaQuery.of(context).size.width / 20,
                      runSpacing: MediaQuery.of(context).size.width / 20,
                      children: controller.plantas
                          .map(
                            (planta) => GestureDetector(
                              child: Hero(
                                tag: 'planta${planta.nome}',
                                child: Container(
                                  height: MediaQuery.of(context).size.width / 2.5,
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(controller.images[controller.plantas.indexOf(planta)]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        planta.nome,
                                        style: const TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.w600, decoration: TextDecoration.none, color: AppColors.color6),
                                      ),
                                    ),
                                    alignment: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.toNamed(PlantPage.route);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
