import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2/security.dart';
import 'package:angular2/router.dart';
import 'package:in_tallinn/structure/content_entry.dart';
import 'package:in_tallinn/service/content/content_service.dart';
import 'package:in_tallinn/service/content/content_click_handler_service.dart';
import 'package:in_tallinn/elements/article_section_component.dart';
import 'package:in_tallinn/logger/logger_service.dart';
import 'package:in_tallinn/structure/site_structure_service.dart';
import 'package:in_tallinn/elements/drawer_subnav_component.dart';
import 'package:in_tallinn/elements/title_card_component.dart';
import 'package:in_tallinn/structure/page_section.dart';

@Component(
    selector: 'sh-content-page',
    styleUrls: const <dynamic>['content_page.css'],
    templateUrl: 'content_page.html',
    encapsulation: ViewEncapsulation.None, /* styling of innerHTML content */
    directives: const <dynamic>[
      SafeInnerHtmlDirective,
      DrawerSubnavComponent,
      TitleCardComponent,
      ArticleSectionComponent,
    ],
    providers: const <dynamic>[
      SiteStructureService,
      ContentClickHandlerService,
    ]
)
class ContentPageComponent implements OnInit, CanReuse, AfterViewInit {
  String pageId;

  final SiteStructureService _struct;
  final ContentService _contentService;
  final ContentClickHandlerService _clickHandler;
  final LoggerService _logService;
  final Router _router;
  final RouteData _routeData;
  final DomSanitizationService _trustService;

  ContentPageComponent(this._struct, this._contentService, this._clickHandler,
      this._logService, this._trustService, this._routeData, this._router);

  Map<String, SafeHtml> contents = <String, SafeHtml>{};

  List<PageSection> get sections => _getChildren(pageId);

  void _getContent(String id) {
    _contentService.getContent(id).then((ContentEntry c) {
      //TODO need only to allow href attribute, everything else could be sanitized
      contents[id] = _trustService.bypassSecurityTrustHtml(c.content);
    });
  }

  List<PageSection> _getChildren(String id) =>
      _struct
          .getPage(id)
          .sections;

  @override
  void ngAfterViewInit() {
    querySelectorAll("sh-article-section").onClick.listen(_clickHandler.handle);
  }

  @override
  void ngOnInit() {
    pageId = _routeData.data['id'];
    _logService.logger.finest(
        "ContentPageComponent - ngOnInit - route: $pageId");
    _getChildren(pageId).forEach((PageSection c) => _getContent(c.id));
  }

  @override //we can reuse this component only if it's activated by the same route
  bool routerCanReuse(ComponentInstruction nextInstruction,
      ComponentInstruction prevInstruction) =>
      prevInstruction?.routeName == nextInstruction?.routeName;

}