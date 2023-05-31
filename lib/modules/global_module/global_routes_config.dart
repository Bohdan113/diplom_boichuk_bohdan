import 'package:diplom_boichuk_bohdan/modules/routes_interface.dart';

class GlobalRoutesConfig {
  static Schemes schemes = Schemes();
  static String route = '/';
  static String moduleRoute = "/globalModule/";
}

class Schemes {
  final review = ReviewRoute.scheme;
  final addNewAudio = AddNewAudioRoute.scheme;
}

class ReviewRoute extends RouteDestination {
  static String scheme = '${GlobalRoutesConfig.route}review';

  @override
  String path() => '${GlobalRoutesConfig.moduleRoute}review';
}

class AddNewAudioRoute extends RouteDestination {
  static String scheme = '${GlobalRoutesConfig.route}addNewAudio';

  @override
  String path() => '${GlobalRoutesConfig.moduleRoute}addNewAudio';
}
