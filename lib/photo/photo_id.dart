enum PhotoCategory { general, section, splash }

class PhotoId {
  String id;
  PhotoCategory type;

  PhotoId(this.id, {this.type: PhotoCategory.general});
}