import 'package:angular2/core.dart';

import 'dart:html';
import 'package:in_tallinn/logger/logger_service.dart';

@Component(
    selector: 'sh-drawer-subnav',
    styleUrls: const <String>['drawer_subnav_component.css'],
    templateUrl: 'drawer_subnav_component.html')
class DrawerSubnavComponent {

  LoggerService _logService;

  DrawerSubnavComponent(@Optional() this._logService);

  @Input()
  List<Map<String, String>> sections;

  void scrollTo(String id) {
    final String scrollTargetId = "#$id-target";

    final Element scrollTarget = querySelector(scrollTargetId);
    if (scrollTarget != null) {
      querySelector("main").scrollTop = scrollTarget.offsetTop;
    } else {
      _logService.logger.warning(
          "Failed to find scroll target $scrollTargetId");
    }
  }

}