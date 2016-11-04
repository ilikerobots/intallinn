import 'dart:async';
import 'package:angular2/core.dart';
import 'dart:convert';
import 'package:http/http.dart';

import 'package:in_tallinn/conf/app_config.dart';
import 'package:in_tallinn/logger/logger_service.dart';
import 'package:in_tallinn/photo/attribution.dart';
import 'package:in_tallinn/photo/photo.dart';
import 'package:in_tallinn/photo/photo_id.dart';
import 'package:in_tallinn/service/photo/photo_service.dart';

@Injectable()
class CordovaPhotoService implements PhotoService {

  final Client _http;
  final AppConfig _config;
  final LoggerService _logger;

  CordovaPhotoService(this._http, this._config, this._logger);

  String _getPhotoUrl(PhotoCategory type, String id) {
    final String url = "/android_asset/www/content/images/${_categoryToPath(type)}/$id.jpg";
    return url;
  }

  @override
  Future<Photo> getPhoto(PhotoId pId) async {
    final Attribution attrib = await _getPhotoAttribution(pId.type, pId.id);
    return new Photo(pId, attrib, url: _getPhotoUrl(pId.type, pId.id));
  }

  Future<Attribution> _getPhotoAttribution(PhotoCategory type,
      String id) async {
    final Attribution attrib = new Attribution("Unknown");
    final String url = "android_asset/www/content/images/${_categoryToPath(type)}/$id.jpg.license";
    try {
      _logger.logger.finest("Fetching license for image id $id");
      final Response response = await _http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = _extractData(response);
        if (json != null) {
          attrib.author = json['author'];
          attrib.url = json['author_url'];
          attrib.attributionText = json['attribution_text'];
          attrib.attributionRequired = json['attribution_required'];
        }
        return attrib;
      } else {
        _handleError(url, "Response ${response.statusCode}");
        return attrib;
      }
    } catch (e) {
      _handleError(url, e.runtimeType);
      return attrib;
    }
  }

  String _categoryToPath(PhotoCategory cat) =>
      cat.toString().replaceFirst("PhotoCategory\.", "").toLowerCase();

  dynamic _extractData(Response resp) => JSON.decode(UTF8.decode(resp.bodyBytes));

  void _handleError(String url, dynamic e) {
    _logger.logger.fine("Failed to obtain license info at $url; $e");
  }

}