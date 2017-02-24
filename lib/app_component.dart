import 'dart:html' show Element, window;

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_title_by_route_service/angular2_title_by_route_service.dart';
import 'package:in_tallinn/page/fourohfour_page_component.dart';
import 'package:in_tallinn/util/util.dart';
import 'package:usage/usage_html.dart';

import 'package:in_tallinn/page/index_page_component.dart';
import 'package:in_tallinn/conf/app_config.dart';
import 'package:in_tallinn/logger/logger_service.dart';
import 'package:in_tallinn/structure/site_structure_service.dart';
import 'package:in_tallinn/structure/page_component_resolver.dart';
import 'package:in_tallinn_content/structure/page.dart';

@Component(
    selector: 'my-app',
    styleUrls: const <String>['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const <dynamic>[
      ROUTER_DIRECTIVES,
      NgIf
    ],
    providers: const <dynamic>[
      SiteStructureService,
      TitleByRouteService,
    ]
)
class AppComponent implements AfterContentInit, OnInit {
  final Router _router;
  final LoggerService _logService;
  final String titlePostfix = "inTallinn";
  bool examplesLoaded = false;
  bool loading = true;
  bool isScrolled = false;

  List<Page> links;
  int fabBottomMax = 150;
  String currentPageClass = "index";

  AppComponent(this._router,
      AppConfig _config,
      TitleByRouteService _titleService,
      SiteStructureService _siteStruct,
      @Optional() this._logService) {
    _titleService.nameStrategy = _setTitle;
    links = _siteStruct.pages.where((Page p) => p.includeInNav);
    _router.config(_getRouteConfig(_siteStruct.pages));

    final Analytics ga = _initAnalytics(_config.analyticsId);
    _router.subscribe((String url) {
      if (url.isEmpty)
        url = "index";
      ga.sendScreenView(url);
    });

    final String loc = window.location.pathname.replaceFirst("\#\/", "");
    if (Util.isWeb) {
      _router.recognize(loc).then((r) {
        if (r == null) {
          _logService.logger.finer(
              "Failed to recognize url $loc, redirecting to /404");
          window.location.assign("/404");
        }
      });
    } else { //app first view is /
      _router.navigateByUrl('/');
    }
  }

  List<RouteDefinition> _getRouteConfig(Iterable<Page> pages) {
    final List<RouteDefinition> config = <RouteDefinition>[];

    pages.forEach((Page p) =>
        config.add(
            new Route(path: "/" + p.id,
                name: p.title,
                component: PageComponentResolver.resolve(p),
                data: <String, dynamic>{'id': p.id}..addAll(p.data)))
    );
    config.add(new Route(path: '/404',
      name: 'FourOhFour',
      component: FourOhFourComponent,
    ));

    config.add(new Route(path: '',
        name: 'Index',
        component: DashboardComponent,
        useAsDefault: true));

    return config;
  }

  String _setTitle(String name, RouteData routeData,
      Map<String, String> params) {
    currentPageClass = name;
    final StringBuffer sb = new StringBuffer();

    if (routeData.data.containsKey('title')) { // if title is in data, use it
      sb.write(routeData.data['title']);
    } else { //otherwise use route name
      if (name == "Index") {
        return titlePostfix;
      } else {
        sb.write(name);
      }
    }

    if (params.containsKey('id')) { // if detail id in params, append it
      sb.write(": ${params['id']}");
    }

    sb.write(" | $titlePostfix");
    return sb.toString();
  }

  void scrollToTop() {
    window.document
        .querySelector("main")
        .scrollTop = 0;
  }

  void scrollEvent() {
    final Element main = window.document.querySelector("main");
    if (main.scrollTop != 0) {
      isScrolled = true;
    } else {
      isScrolled = false;
    }

    final Element scrollFab = window.document.querySelector("#scroll_up_fab");
    if (main.scrollHeight - (main.scrollTop + main.offsetHeight) <
        fabBottomMax - 20) {
      scrollFab.style.bottom = "${fabBottomMax - main.scrollHeight +
          (main.scrollTop + main.offsetHeight)}px";
    } else {
      scrollFab.style.bottom = "20px";
    }
  }

  Analytics _initAnalytics(String id) {
    return new AnalyticsHtml(id, 'in_tallinn_web', '1.0');
  }

  @override
  void ngOnInit() => _printMotd();

  @override
  void ngAfterContentInit() {
    loading = false;
  }

  void _printMotd() {
    _logService?.logger?.children["motd"]?.info(r'''
    
  _    _______    _ _ _             
 (_)  |__   __|  | | (_)            
  _ _ __ | | __ _| | |_ _ __  _ __  
 | | '_ \| |/ _` | | | | '_ \| '_ \ 
 | | | | | | (_| | | | | | | | | | |
 |_|_| |_|_|\__,_|_|_|_|_| |_|_| |_|
 __________________________________ 
|__________________________________|
          (C) 2017 StarHeight Media 
''');
  }
}