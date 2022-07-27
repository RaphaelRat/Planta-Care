import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../data/model/planta/planta_model.dart';

class PlantController extends GetxController {
  final planta = Rxn<Planta>();
  final loading = true.obs;
  final minutes = (-999).obs;
  late Timer mytimer;
  final valueType = 'seg'.obs;

  @override
  void onInit() {
    final ref = FirebaseDatabase.instance.ref('plantas').child('0');
    ref.onValue.listen((event) {
      planta.value = Planta.fromMap(event.snapshot.value as Map<dynamic, dynamic>);

      loading.value = false;
    });

    mytimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      minutes.value =
          DateTime.fromMillisecondsSinceEpoch(DateTime.now().toUtc().millisecondsSinceEpoch - planta.value!.ultimaRega, isUtc: true).minute == 0
              ? DateTime.fromMillisecondsSinceEpoch(DateTime.now().toUtc().millisecondsSinceEpoch - planta.value!.ultimaRega, isUtc: true).second
              : DateTime.fromMillisecondsSinceEpoch(DateTime.now().toUtc().millisecondsSinceEpoch - planta.value!.ultimaRega, isUtc: true).minute;

      if (DateTime.fromMillisecondsSinceEpoch(DateTime.now().toUtc().millisecondsSinceEpoch - planta.value!.ultimaRega, isUtc: true).minute > 0) {
        valueType.value = 'min';
      } else {
        valueType.value = 'seg';
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    mytimer.cancel();
    super.onClose();
  }
}
