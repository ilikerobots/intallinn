import 'dart:async';
import 'package:angular2/core.dart';

import 'package:in_tallinn/photo/photo.dart';
import 'package:in_tallinn/photo/photo_id.dart';
import 'package:in_tallinn/service/photo/photo_service.dart';


@Component(
    selector: 'my-dashboard',
    styleUrls: const <String>['index_page.css'],
    templateUrl: 'index_page.html',
    directives: const <dynamic>[]
)
class DashboardComponent implements OnInit {
  final PhotoService _photoService;
  String fontClass;
  Photo splash;

  DashboardComponent(this._photoService);

  String get splashImageUrl => splash != null ? "url(${splash.url})" : "none";

  @override
  Future<Null> ngOnInit() async {
    splash = await _photoService.getPhoto(
        new PhotoId("tallinn_panorama", type: PhotoCategory.splash));
  }

}