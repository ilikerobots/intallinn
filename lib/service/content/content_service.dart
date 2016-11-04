import 'dart:async';
import 'package:angular2/core.dart';

import 'package:in_tallinn/structure/content_entry.dart';

// ignore: one_member_abstracts
abstract class ContentService {

  Future<ContentEntry> getContent(String id);

}