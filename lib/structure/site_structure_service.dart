import 'package:angular2/core.dart';
import 'package:in_tallinn_content/structure/site_structure.dart';
import 'package:in_tallinn_content/structure/page.dart';
import 'package:in_tallinn_content/structure/content_page.dart';

@Injectable()
class SiteStructureService {

  SiteStructureService();
  
  List<Page> get pages => SiteStructure.pages;

  ContentPage getPage(String id) => pages.firstWhere((Page i) => i.id == id);

}
