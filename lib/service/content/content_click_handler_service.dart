import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:in_tallinn/logger/logger_service.dart';
import 'package:in_tallinn/util/util.dart';

@Injectable()
class ContentClickHandlerService {
  final LoggerService _logger;
  final Router _router;

  EventListener handle;

  ContentClickHandlerService(this._logger, this._router) {
    handle = _handle;
  }

  void _handle(Event e) {
    if (e.target is AnchorElement) {
      final Uri tUri = Uri.parse(e.target.toString());
      final String tHost = tUri.host + (tUri.hasPort ? ":${tUri.port}" : "");
      if (tHost == window.location.host) {
        _router.recognize(tUri.path).then((Instruction i) {
          if (i != null) {
            e.preventDefault();
            _router.navigateByUrl(tUri.path);
          }
        });
      } else if (Util.isApp) { //app opens ext in system browser
        e.preventDefault();
        window.open(tUri.toString(), "_system");
      }
    }
  }
}
