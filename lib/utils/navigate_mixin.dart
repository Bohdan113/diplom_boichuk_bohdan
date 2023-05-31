import 'package:diplom_boichuk_bohdan/modules/routes_interface.dart';
import 'package:diplom_boichuk_bohdan/utils/utils.dart';
import 'package:flutter_modular/flutter_modular.dart';

/*
 Щоб використовувати методи NavigateMixin, підключіть його до будь-якого класу за допомогою with.
 Приклад: class TestClass with NavigateMixin
*/
mixin NavigateMixin {
  // Відкрити новий екран із додаванням їх у загальний стек екранів.
  // Параметр route - роут для нового екрану, наприклад: navigateReplace(CaveRoute());
  Future<void> navigatePush(RouteDestination route) async {
    if (Modular.to.navigateHistory.last.name != route.path()) {
      await Modular.to.pushNamed(
        route.path(),
        arguments: route.args(),
      );
    }
  }

  Future<void> navigateNamedPush(String nameRoute, [Object? arguments]) async {
    await Modular.to.pushNamed(
      nameRoute,
      arguments: arguments,
    );
  }

  Future<void> navigateReplaceAllNamedPush(String nameRoute, [Object? arguments]) async {
    if (Modular.to.navigateHistory.last.name != nameRoute) {
      await Modular.to.pushNamed(
        nameRoute,
        arguments: arguments,
      );
    }
  }

  // Відкрити новий екран зі скиданням всіх екранів у стеку
  void navigateReplaceAll(RouteDestination route) {
    if (Modular.to.navigateHistory.last.name != route.path()) {
      Modular.to.navigate(
        route.path(),
        arguments: route.args(),
      );
    }
  }

  // Відкрити новий екран із заміною поточного в стеку
  Future<void> navigateReplace(RouteDestination route) async {
    if (Modular.to.navigateHistory.last.name != route.path()) {
      await Modular.to.pushReplacementNamed(
        route.path(),
        arguments: route.args(),
      );
    }
  }

// Закрити поточний екран із видаленням його зі стека
  void navigatePop({int count = 1}) {
    Utils.printDebugMode(Modular.to.navigateHistory.length);
    for (var i = 0; i < count; i++) {
      if (canPop()) {
        Modular.to.pop();
      } else if (Modular.to.navigateHistory.length > 2) {
        String path = Modular.to.navigateHistory[Modular.to.navigateHistory.length - 2].name;
        Modular.to.navigateHistory.removeLast();
        Modular.to.navigateHistory.removeLast();
        Modular.to.pushNamed(
          path,
        );
      } else if (Modular.to.navigateHistory.length > 1) {
        Modular.to.pushReplacementNamed(Modular.to.navigateHistory[Modular.to.navigateHistory.length - 2].name);
      }
    }
  }

  // Перевірка чи є поточний екран останнім у стеку екранів
  bool canPop() {
    return Modular.to.canPop();
  }

  // Видалити з стека всі екрани, крім кореневого (початкового екрану)
  void navigateUntilRoot() => Modular.to.popUntil((p0) => p0.isFirst);
}
