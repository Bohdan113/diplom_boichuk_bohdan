import 'package:diplom_boichuk_bohdan/modules/global_module/global_routes_config.dart';
import 'package:diplom_boichuk_bohdan/modules/global_module/screen/add_new_audio_screen.dart';
import 'package:diplom_boichuk_bohdan/modules/global_module/screen/review_all_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GlobalModule extends Module {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => GlobalRoutesConfig(),
        ),
        Bind.factory(
          (i) => TextEditingController(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      GlobalRoutesConfig.schemes.review,
      child: (_, __) => const ReviewAllDataScreen(),
      transition: TransitionType.defaultTransition,
    ),
    ChildRoute(
      GlobalRoutesConfig.schemes.addNewAudio,
      child: (_, __) => const AddNewAudioScreen(),
      transition: TransitionType.defaultTransition,
    ),
      ];
}
