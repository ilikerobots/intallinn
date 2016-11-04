import 'package:in_tallinn/page/content_page_component.dart';
import 'package:in_tallinn/structure/page.dart';
import 'package:in_tallinn/structure/page_section.dart';

class ContentPage extends Page {
  List<PageSection> sections = <PageSection>[];

  ContentPage(String title, {String id: null, String name: null})
      : super(title, id: id, name: name) {
    component = ContentPageComponent;
    includeInNav = true;
  }
}
