import 'package:diplom_boichuk_bohdan/main.dart';
import 'package:flutter/material.dart';

enum Flavor {
  dev,
  stage,
  prod,
}

class FlavorValues {
  FlavorValues({
    required this.bannerColor,
  });

  final Color bannerColor;

  /// Add other flavor specific values, e.g resources, URLs, databases
}

class AppConfig {
  final Flavor flavor;
  final String packageName;
  final String appVersion;
  final String buildNumber;
  final FlavorValues values;
  static AppConfig? _instance;

  factory AppConfig({
    required String appVersion,
    required String buildNumber,
    required String appName,
    required Flavor flavor,
    required FlavorValues values,
  }) {
    final String flavorSuffix = flavor.toString().split('.').last;
    logger.i('App version: $appVersion');
    logger.i('App name: $appName');
    logger.i('Build number: $buildNumber');
    logger.i('flavor suffix: $flavorSuffix');
    _instance ??= AppConfig._internal(
      flavor,
      flavorSuffix,
      appVersion,
      buildNumber,
      values,
    );

    return _instance!;
  }

  AppConfig._internal(
    this.flavor,
    this.packageName,
    this.appVersion,
    this.buildNumber,
    this.values,
  );

  static void initAppConfig({
    required String packageName,
    required String appName,
    required String appVersion,
    required String buildNumber,
  }) {
    if (appName.endsWith("DEV")) {
      AppConfig(
        flavor: Flavor.dev,
        appVersion: appVersion,
        appName: appName,
        buildNumber: buildNumber,
        values: FlavorValues(
          bannerColor: Colors.deepPurpleAccent,
        ),
      );
    } else if (appName.endsWith("STAGE")) {
      AppConfig(
        flavor: Flavor.stage,
        appVersion: appVersion,
        appName: appName,
        buildNumber: buildNumber,
        values: FlavorValues(
          bannerColor: Colors.green,
        ),
      );
    } else {
      AppConfig(
        flavor: Flavor.prod,
        appVersion: appVersion,
        appName: appName,
        buildNumber: buildNumber,
        values: FlavorValues(
          bannerColor: Colors.transparent,
        ),
      );
    }
  }

  static bool isDev() => _instance?.flavor == Flavor.dev;

  static bool isStage() => _instance?.flavor == Flavor.stage;

  static bool isProd() => _instance?.flavor == Flavor.prod;

  static String getAppVersion() => _instance?.appVersion ?? "?";

  static String getBuildNumber() => _instance?.buildNumber ?? "?";
}
