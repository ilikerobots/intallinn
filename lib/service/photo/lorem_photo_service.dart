import 'dart:async';
import 'dart:math';
import 'package:angular2/core.dart';

import 'package:in_tallinn/photo/attribution.dart';
import 'package:in_tallinn/photo/photo.dart';
import 'package:in_tallinn/photo/photo_id.dart';
import 'package:in_tallinn/service/photo/photo_service.dart';

@Injectable()
class LoremPhotoService extends PhotoService {

  static const String loremPixelUrl = "http://lorempixel.com/";
  static const List<String> picCategories = const <String>["city","transport","nightlife"];
  final Random _rnd = new Random();

  LoremPhotoService();

  String _getPhotoUrl(PhotoCategory type, String id) {
    final String caption = id.replaceAll("_","-");
    if (type == PhotoCategory.section) {
      final String cat = picCategories[_rnd.nextInt(picCategories.length)];
      return "${loremPixelUrl}1800/500/$cat/$caption";
    } else if (type == PhotoCategory.splash) {
      return "${loremPixelUrl}1800/1800/city/$caption";
    } else {
      final String cat = picCategories[_rnd.nextInt(picCategories.length)];
      return "${loremPixelUrl}500/500/$cat/$caption";
    }
  }

  @override
  Future<Photo> getPhoto(PhotoId pId) async {
    final Attribution attrib = _getPhotoAttribution(pId.type, pId.id);
    return new Future<Photo>.value(new Photo(pId, attrib, url: _getPhotoUrl(pId.type, pId.id)));
  }

  Attribution _getPhotoAttribution(PhotoCategory type, String id) {
    final Attribution attrib = new Attribution("Unknown");
    attrib.author = "Author";
    attrib.url = loremPixelUrl;
    attrib.attributionText = "Courtesy lorempixum";
    attrib.attributionRequired = false;
    return attrib;
  }

}