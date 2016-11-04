import 'package:in_tallinn/pipe/slugify_pipe.dart';
import 'package:in_tallinn/pipe/camelize_pipe.dart';

class Page {
  String title;
  String id;
  String name;
  bool includeInNav;
  dynamic component;
  Map<String, String> data = <String, String>{};

  Page(this.title, {this.id, this.name, this.component}) {
    if (id == null) {
      id = SlugifyPipe.doTransform(title);
    }
    if (name == null) {
      name = CamelizePipe.doTransform(title);
    }
  }
}
