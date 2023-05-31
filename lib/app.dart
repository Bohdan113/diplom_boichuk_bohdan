import 'package:diplom_boichuk_bohdan/resources/theme/app_theme.dart';
import 'package:diplom_boichuk_bohdan/utils/navigate_mixin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import 'common/widgets/custom_scroll_bahaviour.dart';

class App extends StatefulWidget with NavigateMixin {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          routeInformationParser: Modular.routeInformationParser,
          //TODO when in project added theme remove this line
          darkTheme: AppTheme.lightTheme.themeData,
          routerDelegate: Modular.routerDelegate,
          locale: context.locale,
          theme: AppTheme.of(context).themeData,
          builder: (context, child) {
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child ?? Container(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
