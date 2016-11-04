import 'package:angular2/core.dart';

@Pipe(name: 'camelize')
class CamelizePipe extends PipeTransform {
  String transform(String val, [List<dynamic> args]) =>
      CamelizePipe.doTransform(val, args);


  static String doTransform(String val, [List<dynamic> args]) =>
      val?.replaceAll("_", "-")
          ?.replaceAll(" ", "-")
          ?.toLowerCase()
          ?.split('-')
          ?.map((String e) => e[0].toUpperCase() + e.substring(1))
          ?.join('');

}