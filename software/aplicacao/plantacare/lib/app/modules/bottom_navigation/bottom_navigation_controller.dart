import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  final selectedIndex = 0.obs;
  final pageController = PageController(initialPage: 0);
}
