import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantacare/app/core/theme/app_colors.dart';
import 'package:plantacare/app/data/model/planta/planta_model.dart';

class DevelopTest extends StatelessWidget {
  const DevelopTest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final plantas = RxList<Planta>();
    final ref = FirebaseDatabase.instance.ref('plantas');
    ref.onValue.listen((event) {
      plantas.clear();
      final plantasMap = event.snapshot.value as List;
      for (var value in plantasMap) {
        final planta = value as Map<dynamic, dynamic>;

        plantas.add(Planta.fromMap(planta));
      }
    });
    return Obx(
      (() => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: plantas
              .map((planta) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          planta.nome,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: AppColors.blackSurface),
                            text: 'Regar: ',
                            children: <TextSpan>[
                              TextSpan(
                                text: planta.regarPlanta.toString(),
                                style: TextStyle(fontWeight: FontWeight.w700, color: planta.regarPlanta ? AppColors.green600 : AppColors.red900),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: AppColors.blackSurface),
                            text: 'Regando: ',
                            children: <TextSpan>[
                              TextSpan(
                                text: planta.regando.toString(),
                                style: TextStyle(fontWeight: FontWeight.w700, color: planta.regando ? AppColors.green600 : AppColors.red900),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: AppColors.blackSurface),
                            text: 'Umidade: ',
                            children: <TextSpan>[
                              TextSpan(
                                text: '${planta.umidadeSolo} %',
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: AppColors.blackSurface),
                            text: 'Temperatura: ',
                            children: <TextSpan>[
                              TextSpan(
                                text: '${planta.temperaturaAmb} ºC',
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final ref = FirebaseDatabase.instance.ref('plantas').child(plantas.indexOf(planta).toString());

                            ref.update({"regarPlanta": !planta.regarPlanta});
                          },
                          child: const Text('Regar', style: TextStyle(color: AppColors.whiteSmoke)),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.color4)),
                        )
                      ],
                    ),
                  ))
              .toList())),
    );
  }
}
