import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2/security.dart';

import 'package:in_tallinn/logger/logger_service.dart';
import 'package:in_tallinn/service/content/content_service.dart';
import 'package:in_tallinn/service/content/content_click_handler_service.dart';
import 'package:in_tallinn/structure/content_entry.dart';


@Component(
    selector: 'sh-ask',
    styleUrls: const <String>['about_page.css'],
    encapsulation: ViewEncapsulation.None, /* styling of innerHTML content */
    templateUrl: 'about_page.html',
    directives: const <dynamic>[
      SafeInnerHtmlDirective,
    ],
    providers: const <dynamic>[ContentClickHandlerService]
)
class AskComponent implements OnInit, AfterViewInit {

  final ContentService _contentService;
  final LoggerService _logService;
  final DomSanitizationService _trustService;
  final ContentClickHandlerService _clickHandler;

  static final String pageId = "ask-us";
  SafeHtml contents;

  AskComponent(this._contentService, this._logService,
      this._clickHandler, this._trustService);


  void _getContent(String id) {
    _contentService.getContent(id).then((ContentEntry c) {
      //TODO need only to allow href attribute, everything else could be sanitized
      contents = _trustService.bypassSecurityTrustHtml(c.content);
    });
  }

  @override
  Future<Null> ngOnInit() async {
    _logService.logger.finest("AboutComponent - ngOnInit - route: $pageId");
    _getContent(pageId);
  }

  @override
  ngAfterViewInit() {
    querySelector(".twitter-timeline").parent.append(
        new ScriptElement()
          ..async = true
          ..src = "//platform.twitter.com/widgets.js"
          ..charset = "utf-8"
    );

    querySelectorAll(".mdl-grid").onClick.listen(_clickHandler.handle);
  }
}