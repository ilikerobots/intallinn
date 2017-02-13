import 'dart:html';
import 'dart:async';
import 'package:angular2/core.dart';
import 'package:in_tallinn/logger/logger_service.dart';
import 'package:in_tallinn/service/map/map_service.dart';
import 'package:in_tallinn/structure/site_structure_service.dart';
import 'package:google_maps/google_maps.dart';

@Component(
    selector: 'sh-walking-tours-page',
    styleUrls: const <String>['walking_tours_page.css'],
    templateUrl: 'walking_tours_page.html',
    directives: const <dynamic>[
    ],
    providers: const <dynamic>[
      SiteStructureService,
    ]
)
class WalkingToursPageComponent implements AfterContentInit, AfterViewInit {

  MapService _mapService;
  LoggerService _logger;
  GMap gMap;
  static DateTime now = new DateTime.now();
  final String mapUrl = 'https://intallinn.ee/content/content/map/TallinnOldTownWalkingRoutes.kmz?${now
      .year}.${now.month}.${now.day}';
  final LatLng center = new LatLng(59.439267942849284, 24.751540917253580);

  WalkingToursPageComponent(this._mapService, this._logger);

  @override
  void ngAfterContentInit() {
    final Element el = window.document.querySelector("#map");
    final mapOptions = new MapOptions()
      ..zoom = 14
      ..center = center;
    gMap = _mapService.getMap(el, mapOptions);

    final walkLayer = new KmlLayer()
      ..url = mapUrl;
    walkLayer.map = gMap;
  }

  void ngAfterViewInit() {
    //Need to trigger a resize after the map is loaded
    //FIXME This is solution is timing dependent
    new Future.delayed(new Duration(milliseconds: 500), () {
      event.trigger(gMap, 'resize', []);
      gMap
        ..center = center
        ..zoom = 14;
    }

    );
  }
}