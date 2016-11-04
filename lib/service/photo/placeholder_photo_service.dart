import 'dart:async';
import 'dart:math';
import 'package:angular2/core.dart';

import 'package:in_tallinn/photo/attribution.dart';
import 'package:in_tallinn/photo/photo.dart';
import 'package:in_tallinn/photo/photo_id.dart';
import 'package:in_tallinn/service/photo/photo_service.dart';

@Injectable()
class PlaceholderPhotoService implements PhotoService {

  static const String placeholderItUrl = "http://placehold.it/";
  final Random _rnd = new Random();

  PlaceholderPhotoService();

  String _getPhotoUrl(PhotoCategory type, String id) {
    if (type == PhotoCategory.section) {
      return "${placeholderItUrl}1800x500/?text=$id";
    } else if (type == PhotoCategory.splash) {
      return "${placeholderItUrl}2200x2200/?text=$id";
    } else {
      return "${placeholderItUrl}500x500/?text=$id";
    }
  }

  @override
  Future<Photo> getPhoto(PhotoId pId) async {
    final Attribution attrib = _getPhotoAttribution(pId.type, pId.id);
    return new Future<Photo>.value(
        new Photo(pId, attrib, url: _getPhotoUrl(pId.type, pId.id)));
  }

  Attribution _getPhotoAttribution(PhotoCategory type, String id) {
    final Attribution attrib = new Attribution("Unknown");
    attrib.author = "Author";
    attrib.url = placeholderItUrl;
    attrib.attributionText = "Courtesy placeholder.it";
    attrib.attributionRequired = _rnd.nextBool();
    return attrib;
  }

}