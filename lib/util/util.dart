import 'dart:html' show window;

class Util {

  static bool get isWeb => !isApp;

  static bool get isApp => window.location.protocol == 'file:';
}