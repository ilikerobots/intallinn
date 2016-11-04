import 'dart:html' show document;
import 'dart:js' as js;
import 'package:dartins/dartins.dart';

class Cordova {

  static void init() {
    document.on['offline'].listen((_) {
      networkNotificationAccept(null);
    });
  }

  static void networkNotificationAccept(_) {
    if (Connection.type == ConnectionType.NONE) {
      final js.JsObject notify = js.context['navigator']['notification'];
      notify.callMethod("alert", [
        "This app requires an internet connection.",
        js.allowInterop(networkNotificationAccept),
        "Network not found",
        "Retry"
      ]);
    }
  }


}
