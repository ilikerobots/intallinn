import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:fnx_config/fnx_config_read.dart';


@Injectable()
class AppConfig {
  static const String contentServiceLorem  = "lorem";
  static const String contentServicePlaceholder  = "placeholder";
  static const String contentServiceClient  = "client";
  static const String photoServiceLorem  = "lorem";
  static const String photoServicePlaceholder  = "placeholder";
  static const String photoServiceClient  = "client";
  static const String locationStrategyPath  = "path";
  static const String locationStrategyHash  = "hash";

  String baseHref = "/"; // 
  Level logLevel; //Default log level
  bool attributeAllPhotos; //attribute all, even if not required by license
  String contentService; // 
  String photoService; // 
  String contentUrlPrefix; //url prefix to content if using client
  String photoUrlPrefix; //url prefix to photos if using client
  String locationStrategy; 
  String siteName; //url prefix to content
  String analyticsId; //Analytics Tracking ID
}

AppConfig appConfigFactory() =>
    new AppConfig()
      ..logLevel = Level.WARNING
      ..baseHref = fnxConfig()["baseHref"]
      ..attributeAllPhotos = fnxConfig()["attributeAllPhotos"]
      ..contentUrlPrefix = fnxConfig()["contentUrlPrefix"]
      ..photoUrlPrefix = fnxConfig()["photoUrlPrefix"]
      ..contentService = fnxConfig()["contentService"]
      ..photoService = fnxConfig()["photoService"]
      ..locationStrategy = fnxConfig()["locationStrategy"]
      ..analyticsId = fnxConfig()["analyticsId"]
;
