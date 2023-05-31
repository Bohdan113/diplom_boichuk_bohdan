import 'package:diplom_boichuk_bohdan/modules/global_module/global_module.dart';
import 'package:diplom_boichuk_bohdan/modules/global_module/global_routes_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';

import 'global_module/cubit/global_cubit.dart';
import 'global_module/screen/splash_screen.dart';


class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => TextEditingController(),
        ),
        Bind(
          (_) => Logger(
            printer: PrettyPrinter(),
          ),
        ),
        Bind((i) => GlobalCubit()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => const SplashScreen(),
          transition: TransitionType.defaultTransition,
        ),
        ModuleRoute(
          GlobalRoutesConfig.moduleRoute,
          module: GlobalModule(),
          transition: TransitionType.defaultTransition,
        ),
      ];
}
