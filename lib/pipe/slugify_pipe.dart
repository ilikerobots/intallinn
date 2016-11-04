import 'package:angular2/core.dart';

@Pipe(name: 'slugify')
class SlugifyPipe extends PipeTransform {

  String transform(String val, [List<dynamic> args]) =>
      SlugifyPipe.doTransform(val, args);

  static String doTransform(String val, [List<dynamic> args]) =>
      val?.replaceAll("_", "-")?.replaceAll(" ", "-")?.toLowerCase();
}