import 'package:angular2/core.dart';

import 'dart:async';
import 'package:in_tallinn/conf/app_config.dart';
import 'package:in_tallinn/service/photo/photo_service.dart';
import 'package:in_tallinn_content/photo/photo.dart';
import 'package:in_tallinn_content/photo/photo_id.dart';

@Component(
  selector: 'sh-titlecard',
  styleUrls: const <String>['title_card_component.css'],
  templateUrl: 'title_card_component.html',
)
class TitleCardComponent implements OnInit {
  final AppConfig _config;
  final PhotoService _photoService;

  Photo photo;

  TitleCardComponent(this._config, this._photoService);

  @Input() String bgColor = "white";

  @Input() PhotoId photoId;

  @override
  Future<Null> ngOnInit() async {
    if (photoId != null) {
      photo = await _photoService.getPhoto(photoId);
    }
  }

  String get bgImageUrl => photo != null ? "url(${photo.url})" : "none";

  bool get showAttribution =>
      photo != null &&
          (_config.attributeAllPhotos || photo.attribution.attributionRequired);

}

