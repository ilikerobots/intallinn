import 'dart:async';
import 'package:in_tallinn/photo/photo.dart';
import 'package:in_tallinn/photo/photo_id.dart';

// ignore: one_member_abstracts
abstract class PhotoService {

  Future<Photo> getPhoto(PhotoId pId);

}