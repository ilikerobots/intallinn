import 'dart:async';
import 'dart:math';
import 'package:angular2/core.dart';
import 'package:http/http.dart';

import 'package:in_tallinn/conf/app_config.dart';
import 'package:in_tallinn/structure/content_entry.dart';
import 'package:in_tallinn/logger/logger_service.dart';
import 'package:in_tallinn/service/content/content_service.dart';

@Injectable()
class LoremContentService extends ContentService {
  final Random _rnd = new Random();
  final Client _http;
  final AppConfig _config;
  final LoggerService _logger;

  LoremContentService(this._http, this._config, this._logger);

  @override
  Future<ContentEntry> getContent(String id) async {
    final String url = "${_config.contentUrlPrefix}section/$id.html";
    try {
      final Response response = await _http.get(url);
      return new ContentEntry(id, tweakContentHtml(response.body));
    } catch (e) {
      _handleError(url, e.runtimeType);
      return new ContentEntry(
          id, "<h3>Error</h3><p>Failed to locate content at $url</p>");
    }
  }

  String tweakContentHtml(String html) {
    String outHtml = html;
    if (_rnd.nextBool()) {
      outHtml = outHtml.replaceFirst(
          "<blockquote cite='http://loripsum.net'>", "<p class='callout tip'>");
      outHtml = outHtml.replaceFirst("<\/blockquote>", "<\/p>");
    }
    if (_rnd.nextBool()) {
      outHtml = outHtml.replaceFirst("<blockquote cite='http://loripsum.net'>",
          "<p class='callout alert'>");
      outHtml = outHtml.replaceFirst("<\/blockquote>", "<\/p>");
    }
    return outHtml;
  }

  void _handleError(String url, dynamic e) {
    _logger.logger.fine("Failed to obtain license info at $url; $e");
  }

}