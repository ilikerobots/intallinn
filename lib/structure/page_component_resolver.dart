import 'package:in_tallinn/page/content_page_component.dart';
import 'package:in_tallinn/page/about_page_component.dart';
import 'package:in_tallinn/page/ask_page_component.dart';
import 'package:in_tallinn/page/walking_tours_page_component.dart';
import 'package:in_tallinn_content/structure/page.dart';

class PageComponentResolver {
  static dynamic resolve(Page p) {
    dynamic component;
    switch (p.name) {
      case "walking-tours":
        component = WalkingToursPageComponent;
        break;
      case "about":
        component = AboutComponent;
        break;
      case "ask-us":
        component = AskComponent;
        break;
      default:
        component = ContentPageComponent;
    }
    return component;
  }
}
