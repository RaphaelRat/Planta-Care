import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../data/model/planta/planta_model.dart';

class HomeController extends GetxController {
  final plantas = RxList<Planta>();
  final images = ['assets/img/Rosa_de_Pedra.png', 'assets/img/Planta_de_Jade.png', 'assets/img/Planta Fantasma.png'];
  final isLoading = true.obs;

  @override
  void onInit() {
    final ref = FirebaseDatabase.instance.ref('plantas');
    ref.onValue.listen((event) {
      isLoading.value = true;

      plantas.clear();
      final plantasMap = event.snapshot.value as List;
      for (var value in plantasMap) {
        final planta = value as Map<dynamic, dynamic>;

        plantas.add(Planta.fromMap(planta));
      }

      isLoading.value = false;
    });

    super.onInit();
  }
}
