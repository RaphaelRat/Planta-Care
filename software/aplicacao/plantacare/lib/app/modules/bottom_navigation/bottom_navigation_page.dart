import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantacare/app/modules/develop_test/show_plants.dart';

import '../../core/theme/app_colors.dart';
import '../home/home_page.dart';
import './bottom_navigation_controller.dart';

class BottomNavigationPage extends GetView<BottomNavigationController> {
  static String route = '/';

  const BottomNavigationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: PageView(
          controller: controller.pageController,
          scrollDirection: Axis.horizontal,
          children: const [
            HomePage(),
            DevelopTest(),
            Center(child: Text('Em construção')),
          ],
          onPageChanged: controller.selectedIndex,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '', tooltip: 'Página inicial', activeIcon: Icon(Icons.home_sharp)),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: '', tooltip: 'Estatísticas'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: '', tooltip: 'Seu perfil', activeIcon: Icon(Icons.person_sharp)),
          ],
          currentIndex: controller.selectedIndex.value,
          onTap: (index) => controller.pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease),
          selectedItemColor: AppColors.color1,
          backgroundColor: AppColors.whiteSmoke,
          elevation: 10,
        ),
      ),
    );
  }
}
