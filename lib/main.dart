import 'dart:io';

import 'package:diplom_boichuk_bohdan/app.dart';
import 'package:diplom_boichuk_bohdan/common/flavors_utils.dart';
import 'package:diplom_boichuk_bohdan/modules/app_module.dart';
import 'package:diplom_boichuk_bohdan/resources/hive/hive_resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

final logger = Logger(printer: PrettyPrinter());

// ignore: constant_identifier_names
const String _PATH_TO_TRANSLATIONS_FILE = 'assets/translations';

// ignore: constant_identifier_names
const String ENGLISH_LOCALE_CODE = 'en';
// ignore: constant_identifier_names
const String UKRAINE_LOCALE_CODE = 'uk';

// ignore: constant_identifier_names
const String UK_COUNTRY_CODE = 'united_kingdom';

const Map<String, Locale> supportedLocales = {
  ENGLISH_LOCALE_CODE: Locale(ENGLISH_LOCALE_CODE),
  UKRAINE_LOCALE_CODE: Locale(UKRAINE_LOCALE_CODE),
};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await HiveResources().initHive();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(0), //top bar color
      statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
      statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
    ),
  );
  await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    AppConfig.initAppConfig(
      packageName: packageInfo.packageName,
      appName: packageInfo.appName,
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }).whenComplete(
    () => runApp(ModularApp(
        module: AppModule(),
        child: EasyLocalization(
          supportedLocales: supportedLocales.values.toList(),
          fallbackLocale: supportedLocales[UKRAINE_LOCALE_CODE],
          startLocale: const Locale(UKRAINE_LOCALE_CODE),
          path: _PATH_TO_TRANSLATIONS_FILE,
          saveLocale: true,
          useOnlyLangCode: true,
          child: const App(),
        ))),
  );
}
