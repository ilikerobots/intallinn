import 'package:in_tallinn/photo/photo_id.dart';

class PageSection {
  String id;
  String title;
  String color;
  String icon;
  PhotoId photoId;

  PageSection(this.id, this.title, {this.icon: "link"}) {
    photoIdString = id;
  }

  set photoIdString(String s) {
    photoId = new PhotoId(s, type: PhotoCategory.section);
  }

}