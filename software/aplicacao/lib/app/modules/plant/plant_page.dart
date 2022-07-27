import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantacare/app/core/theme/app_colors.dart';
import 'package:plantacare/app/modules/plant/plant_controller.dart';

class PlantPage extends GetView<PlantController> {
  const PlantPage({Key? key}) : super(key: key);
  static String route = '/plant';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.info_outline),
          )
        ],
      ),
      body: Obx(
        () => controller.loading.value
            ? const CircularProgressIndicator()
            : Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors.color4,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Hero(
                        child: Image.asset('assets/img/Rosa_de_pedra_2.png'),
                        tag: 'planta${controller.planta.value!.nome}',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height / 2.4),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                        color: AppColors.color5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.planta.value!.nome,
                              style: const TextStyle(color: AppColors.color6, fontWeight: FontWeight.w500, fontSize: 36),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '${controller.planta.value!.temperaturaAmb} ºC',
                                      style: const TextStyle(color: AppColors.color6, fontWeight: FontWeight.w500, fontSize: 36),
                                    ),
                                    const Text(
                                      'Temperatura',
                                      style: TextStyle(color: AppColors.color6, fontWeight: FontWeight.w400, fontSize: 20),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${controller.planta.value!.umidadeSolo} %',
                                      style: const TextStyle(color: AppColors.color6, fontWeight: FontWeight.w500, fontSize: 36),
                                    ),
                                    const Text(
                                      'Umidade Solo',
                                      style: TextStyle(color: AppColors.color6, fontWeight: FontWeight.w400, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '${controller.planta.value!.umidadeAmb} %',
                                      style: const TextStyle(color: AppColors.color6, fontWeight: FontWeight.w500, fontSize: 36),
                                    ),
                                    const Text(
                                      'Umidade Ambiente',
                                      style: TextStyle(color: AppColors.color6, fontWeight: FontWeight.w400, fontSize: 20),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    controller.minutes.value == -999
                                        ? const CircularProgressIndicator(
                                            color: AppColors.color6,
                                          )
                                        : Text(
                                            '${controller.minutes.value} ${controller.valueType.value}',
                                            style: const TextStyle(color: AppColors.color6, fontWeight: FontWeight.w500, fontSize: 36),
                                          ),
                                    const Text(
                                      'Última rega',
                                      style: TextStyle(color: AppColors.color6, fontWeight: FontWeight.w400, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final ref = FirebaseDatabase.instance.ref('plantas').child('0');

                                      if (controller.planta.value!.regarPlanta == false) {
                                        final now = DateTime.now().toUtc().millisecondsSinceEpoch;
                                        ref.update({"ultimaRega": now});
                                      }

                                      ref.update({"regarPlanta": !controller.planta.value!.regarPlanta});
                                    },
                                    child: Text(controller.planta.value!.regarPlanta ? 'Regando' : 'Regar',
                                        style: const TextStyle(color: AppColors.whiteSmoke)),
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.color4)),
                                  ),
                                ),
                                const SizedBox(width: 16),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
