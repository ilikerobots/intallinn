import 'package:angular2/core.dart';
import 'package:in_tallinn/page/about_page_component.dart';
import 'package:in_tallinn/page/ask_page_component.dart';
import 'package:in_tallinn/page/walking_tours_page_component.dart';
import 'package:in_tallinn/structure/page.dart';
import 'package:in_tallinn/structure/page_section.dart';
import 'package:in_tallinn/structure/content_page.dart';

@Injectable()
class SiteStructureService {
  static final List<Page> pages = <Page>[
    new ContentPage("Basics")
      ..sections.add(new PageSection("history", "History", icon: "restore"))
      ..sections.add(new PageSection("people", "People", icon: "people"))
      ..sections.add(new PageSection("climate", "Climate", icon: "wb_sunny"))
      ..sections.add(new PageSection("language", "Language", icon: "mode_comment"))
      ..sections.add(new PageSection("currency", "Currency", icon: "euro_symbol"))
      ..sections.add(new PageSection("safety", "Safety", icon: "traffic"))
      ..sections.add(new PageSection("power", "Power", icon: "power"))
      ..sections.add(new PageSection("internet", "Internet/WiFi", icon: "wifi")),
    new ContentPage("Transport")
      ..sections.add(new PageSection("airport", "Airport", icon: "airplanemode_active"))
      ..sections.add(new PageSection("seaport", "Sea Port", icon: "directions_boat"))
      ..sections.add(new PageSection("auto-rental", "Auto Rental", icon: "directions_car"))
      ..sections.add(new PageSection("public-transport", "Public Transport", icon: "directions_transit"))
      ..sections.add(new PageSection("taxis", "Taxis", icon: "local_taxi"))
      ..sections.add(new PageSection("bikes", "Bikes", icon: "directions_bike")),
    new ContentPage("Sightseeing")
      ..sections.add(new PageSection("tourist-office", "Tourist Office", icon: "info_outline"))
      ..sections.add(new PageSection("parks", "Parks", icon: "nature_people"))
      ..sections.add(new PageSection("neighborhoods", "Neighborhoods", icon: "zoom_out_map"))
      ..sections.add(new PageSection("museums", "Museums ", icon: "local_activity"))
      ..sections.add(new PageSection("walking", "Walking Tours ", icon: "directions_walk")
        ..photoIdString = "walking-tours")
      ..sections.add(new PageSection("seasonal-events", "Seasonal Events", icon: "event"))
      ..sections.add(new PageSection("tallinn-card", "Tallinn Card", icon: "card_travel")),
    new ContentPage("Dining and Nightlife")
      ..sections.add(new PageSection("cuisine", "Cuisine", icon: "local_dining"))
      ..sections.add(new PageSection("dining", "Dining", icon: "restaurant"))
      ..sections.add(new PageSection("nightlife", "Nightlife", icon: "local_bar")),
//    new ContentPage("Accommodation"),
    new ContentPage("Elsewhere in Estonia")
     ..sections.add(new PageSection("destinations-outside-tallinn", "Destinations", icon: "map"))
      ..sections.add(new PageSection("getting-away", "Getting Away", icon: "explore")),
    new Page("Walking Tours", name: "walking-tours", component: WalkingToursPageComponent) 
      ..includeInNav = false,
    new Page("About", name: "about", component: AboutComponent)..includeInNav = false,
    new Page("Ask Us", name: "ask-us", component: AskComponent)..includeInNav = true,
  ];

  SiteStructureService();

  ContentPage getPage(String id) => pages.firstWhere((Page i) => i.id == id);


}
