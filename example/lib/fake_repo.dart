import 'dart:async';
import 'dart:math';

class FakeRepo {
  static Future<String> greet(String name) {
    final random = Random();
    final isValid = random.nextBool();

    return Future.delayed(
      const Duration(seconds: 2),
      () => isValid
          ? Future.value('Hello, $name! 👋')
          : Future.error('Invalid name!'),
    );
  }

  static Future<bool> isUnique(String name) {
    final usedNames = {'bob', 'alice'};

    return Future.delayed(
      const Duration(seconds: 2),
      () => !usedNames.contains(name),
    );
  }
}
