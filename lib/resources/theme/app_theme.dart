import 'package:flutter/material.dart';

import 'app_text_theme.dart';
import 'app_theme_color_scheme.dart';
import 'elevation.dart';

class AppTheme {
  static Iterable<AppTheme> themes = [lightTheme, darkTheme];

  static AppTheme darkTheme = _initializeTheme(
    colorScheme: AppThemeColorScheme.dark,
    baseThemeData: ThemeData.dark(),
  );

  static AppTheme lightTheme = _initializeTheme(
    colorScheme: AppThemeColorScheme.light,
    baseThemeData: ThemeData.light(),
  );

  final ThemeData themeData;

  final AppTextTheme textTheme;

  final AppThemeColorScheme colors;

  AppTheme({
    required this.themeData,
    required this.textTheme,
    required this.colors,
  });

  @override
  int get hashCode => themeData.hashCode ^ textTheme.hashCode ^ colors.hashCode;

  bool get isDark => this == darkTheme;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme &&
          runtimeType == other.runtimeType &&
          themeData == other.themeData &&
          textTheme == other.textTheme &&
          colors == other.colors;

  static AppTheme of(BuildContext context) {
    final brightness = MediaQueryData.fromWindow(
      WidgetsBinding.instance.window,
    ).platformBrightness;
    return brightness == Brightness.dark ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  static ThemeData _createBaseThemeData(
    AppThemeColorScheme colorScheme,
    AppTextTheme textTheme,
    ThemeData baseThemeData,
  ) =>
      baseThemeData.copyWith(
        primaryColor: colorScheme.blue,
        // ignore: deprecated_member_use
        backgroundColor: colorScheme.surface,
        cardColor: colorScheme.white,
        colorScheme: colorScheme,
        // ignore: deprecated_member_use
        errorColor: colorScheme.error,
        textTheme: textTheme,
        primaryTextTheme: textTheme,
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Color.fromRGBO(27, 26, 57, 1),
        ),
        appBarTheme: baseThemeData.appBarTheme.copyWith(
          elevation: Elevation.$0dp.value,
          color: colorScheme.surface,
          centerTitle: false,
          iconTheme: baseThemeData.iconTheme.copyWith(
            color: colorScheme.white,
          ),
          actionsIconTheme: baseThemeData.iconTheme.copyWith(
            color: colorScheme.white,
          ),
        ),
        bottomNavigationBarTheme: baseThemeData.bottomNavigationBarTheme.copyWith(
          selectedItemColor: colorScheme.blue,
          unselectedItemColor: colorScheme.white,
          elevation: Elevation.$24dp.value,
          backgroundColor: colorScheme.surface,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: baseThemeData.iconTheme.copyWith(
            color: colorScheme.white,
          ),
          unselectedIconTheme: baseThemeData.iconTheme.copyWith(
            color: colorScheme.white,
          ),
        ),
        buttonTheme: baseThemeData.buttonTheme.copyWith(
          minWidth: 0,
          padding: EdgeInsets.zero,
          buttonColor: colorScheme.white,
          colorScheme: baseThemeData.colorScheme.copyWith(
            secondary: colorScheme.secondary,
          ),
        ),
        primaryIconTheme: baseThemeData.iconTheme.copyWith(
          color: colorScheme.white,
        ),
        inputDecorationTheme: baseThemeData.inputDecorationTheme.copyWith(
          labelStyle: textTheme.regular14.copyWith(
            color: colorScheme.black,
          ),
          alignLabelWithHint: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: colorScheme.black,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: colorScheme.black,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: colorScheme.error,
            ),
          ),
          errorMaxLines: 2,
        ),
        bottomSheetTheme: baseThemeData.bottomSheetTheme.copyWith(
          backgroundColor: Colors.transparent,
        ),
      );

  static AppTheme _initializeTheme({
    required AppThemeColorScheme colorScheme,
    required ThemeData baseThemeData,
  }) {
    final textTheme = AppTextTheme.byColorScheme(colorScheme);
    return AppTheme(
      colors: colorScheme,
      themeData: _createBaseThemeData(
        colorScheme,
        textTheme,
        baseThemeData,
      ),
      textTheme: textTheme,
    );
  }
}

class AppThemeProvider extends StatefulWidget {
  final Widget child;
  final AppTheme initialTheme;

  const AppThemeProvider({
    Key? key,
    required this.initialTheme,
    required this.child,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppThemeProviderState createState() => _AppThemeProviderState();
}

class _AppThemeBindingScope extends InheritedWidget {
  final _AppThemeProviderState applicationThemeProviderState;

  const _AppThemeBindingScope({
    Key? key,
    required this.applicationThemeProviderState,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_AppThemeBindingScope oldWidget) => true;
}

class _AppThemeProviderState extends State<AppThemeProvider> {
  late AppTheme currentTheme;

  @override
  Widget build(BuildContext context) {
    return _AppThemeBindingScope(
      applicationThemeProviderState: this,
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    currentTheme = widget.initialTheme;
  }

  void updateTheme(AppTheme newTheme) {
    if (newTheme != currentTheme) {
      setState(() {
        currentTheme = newTheme;
      });
    }
  }
}

extension AppThemeTextStyleExtensions on AppThemeTextStyle {
  TextStyle white({double opacity = 1}) => copyWith(
        color: colorScheme.white.withOpacity(opacity),
      );

  TextStyle black({double opacity = 1}) => copyWith(
        color: colorScheme.black.withOpacity(opacity),
      );

  TextStyle veryLightPink({double opacity = 1}) => copyWith(
        color: colorScheme.veryLightPink.withOpacity(opacity),
      );

  TextStyle grey({double opacity = 1}) => copyWith(
        color: colorScheme.grey.withOpacity(opacity),
      );

  TextStyle brownGray({double opacity = 1}) => copyWith(
        color: colorScheme.black.withOpacity(opacity),
      );
}
