import 'package:in_tallinn/photo/attribution.dart';
import 'package:in_tallinn/photo/photo_id.dart';

class Photo {
  PhotoId id;
  Attribution attribution;
  String url;

  Photo(this.id, this.attribution, {this.url: null});
}