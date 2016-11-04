import 'dart:html';
import 'package:angular2/core.dart';

import 'package:google_maps/google_maps.dart';

@Injectable()
class MapService {
  GMap gMap;

  MapService();

  GMap getMap(Element el, MapOptions mapOptions) {
    gMap = new GMap(el, mapOptions);
    return gMap;
  }

}