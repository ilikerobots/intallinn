@MirrorsUsed(override: '*')
import 'dart:mirrors'; //mirrors not used elsewhere, explicitly discard all symbols

import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:http/http.dart';
import 'package:http/browser_client.dart';
import 'package:fnx_config/fnx_config_read.dart';

import 'package:in_tallinn/app_component.dart';
import 'package:in_tallinn/conf/app_config.dart';
import 'package:in_tallinn/service/content/client_content_service.dart';
import 'package:in_tallinn/service/content/content_service.dart';
import 'package:in_tallinn/service/content/lorem_content_service.dart';
import 'package:in_tallinn/service/content/placeholder_content_service.dart';
import 'package:in_tallinn/service/map/map_service.dart';
import 'package:in_tallinn/service/photo/client_photo_service.dart';
import 'package:in_tallinn/service/photo/cordova_photo_service.dart';
import 'package:in_tallinn/service/photo/lorem_photo_service.dart';
import 'package:in_tallinn/service/photo/photo_service.dart';
import 'package:in_tallinn/service/photo/placeholder_photo_service.dart';
import 'package:in_tallinn/logger/console_logger.dart';
import 'package:in_tallinn/logger/logger_service.dart';
import 'package:in_tallinn/app/cordova.dart';
import 'package:in_tallinn/util/util.dart';


void main() {
  Cordova.init();

  bootstrap(AppComponent, <dynamic>[

    ROUTER_PROVIDERS,
    provide(APP_BASE_HREF, useValue: '/'),
    provide(LoggerService, useClass: ConsoleLogger),
    provide(MapService),
    provide(AppConfig,
        useFactory: appConfigFactory, deps: const <Object>[]),
    provide(Client,
        useFactory: () => new BrowserClient(), deps: const <Object>[]),
    provide(ContentService,
        useClass: _getContentProvider(fnxConfig()["contentService"])),
    provide(PhotoService,
        useClass: _getPhotoProvider(fnxConfig()["photoService"])),
    provide(LocationStrategy,
        useClass: _getLocationStrategy(fnxConfig()["locationStrategy"])),
  ]
  );
}

Object _getLocationStrategy(String locationStrategyConfig) {
  Object provider;
  switch (locationStrategyConfig) {
    case (AppConfig.locationStrategyHash) :
      provider = HashLocationStrategy;
      break;
    case (AppConfig.locationStrategyPath) :
      provider = PathLocationStrategy;
      break;
    default:
      provider = PathLocationStrategy;
  }
  return provider;
}


Object _getContentProvider(String contentServiceConfig) {
  Object provider;
  switch (contentServiceConfig) {
    case (AppConfig.contentServiceLorem) :
      provider = LoremContentService;
      break;
    case (AppConfig.contentServicePlaceholder) :
      provider = PlaceholderContentService;
      break;
    case (AppConfig.contentServiceClient) :
      provider = ClientContentService;
      break;
    default:
      provider = ClientContentService;
  }
  return provider;
}

Object _getPhotoProvider(String photoServiceConfig) {
  Object provider;

  if (Util.isApp) {
    provider = CordovaPhotoService;
  } else {
    switch (photoServiceConfig) {
      case (AppConfig.photoServiceLorem) :
        provider = LoremPhotoService;
        break;
      case (AppConfig.photoServicePlaceholder) :
        provider = PlaceholderPhotoService;
        break;
      case (AppConfig.photoServiceClient) :
        provider = ClientPhotoService;
        break;
      default:
        provider = ClientPhotoService;
    }
  }
  return provider;
}


