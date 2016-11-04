# inTallinn 

A [travel tips website and app for visitors to Tallinn, Estonia](https://intallinn.ee). The code is written in Angular2 Dart.  

## Content

inTallinn relies on providers resolving 
 * article (section) HTML content
 * URLs to photo assets
 * Photo licensing info in json format

Production content assets are not contained in this repository, as some are protected by non-open license.  

However, the application can be run with several different content provider configurations which utilize open-sourced content or placeholders. The provider implementations are located in `lib/service/content` and `lib/service/photo`.

## Running

The app may be run as usual with `pub serve`.  See the next section for configuring and using alternate serve modes.

## Profiles

The app utilizes [fnx_config](https://pub.dartlang.org/packages/fnx_config) which allows easily switching amongst pre-packaged configurations.

To execute with a profile, run `pub serve --mode <profile_name>`  where profile_name corresponds to a config yaml `lib/conf/config_<profile_name>.yaml`.

Note the default mode is `debug` and therefore uses the `config_debug.yaml` config.

The modes which have included config are:
* **debug**: This profile generates text content from a internal lorem ipsum generator and retrieves photo content from [placehold.it](http://placehold.it).

* **loremipsum**: This profile retrieves text content from [loripsum.net](http://loripsum.net) and photo content from [lorempixel.com](http://lorempixel.com).

* **localcontent**: This profile retrieves text and photo content from a generic web base URL.  See the [inTallinn content provider repo](https://github.com/ilikerobots/intallinn_content) for information on setting up this provider.

* **release**: Production inTallinn.ee settings

These configs may be modified or additional created as needed.

Note that your browser may block request to external text content providers due to CORS issues.  If so, either proxy the requests or temporarily disable security on your browser (DO SO CAUTIOUSLY).


## Site Structure

The major page headings and sub-sections within are defined in `SiteStructureService` located in `lib/structure/site_structure_service.dart`.  An excerpt:

```dart
    new ContentPage("Sightseeing")
      ..sections.add(new PageSection("tourist-office", "Tourist Office", icon: "info_outline"))
      ..sections.add(new PageSection("walking", "Walking Tours ", icon: "directions_walk")
        ..photoIdString = "walking-tours")
      ..sections.add(new PageSection("seasonal-events", "Seasonal Events", icon: "event"))
    new ContentPage("Dining and Nightlife")
      ..sections.add(new PageSection("cuisine", "Cuisine", icon: "local_dining"))
      ..sections.add(new PageSection("dining", "Dining", icon: "restaurant"))
```

## Styling

The application utilizes [Material Design Light (MDL)](https://getmdl.io/) for styling, which doesn't always play nice with Angular2 (or vice versa, depending on your viewpoint).  However, with the limited interactivity of this app, the difficulties are minimized.

## Ionic/Cordova app

The Dart application is Cordova ready.  However, it requires access to a local repo of [inTallinn content provider repo](https://github.com/ilikerobots/intallinn_content) in order to package up photo assets. The script `app/ionic/tools/syncAppContent.sh` should be updated with the proper path to this repo.

The build scripts will also require `ionic` and `vulcanize` on the path.

To set up the environment for the first time, run:

```sh
cd app/ionic  
./tools/reset.sh 

```

After this step, changes to the Dart code or content repo can be synced and an apk built using the following:
```sh
./tools/syncAppContent.sh  # pub build, vulcanize
ionic build android # build apk
```

The apk can be executed with `ionic run android` or `ionic emulate android`.

## Further reading

See my Medium.com blog posts that describe the development of the content asset providers used in this app:
 * [Developing Angular2 Dart Asset Services, Part 1](https://medium.com/@mike_99824/developing-angular2-dart-asset-services-part-1-a3dfda68f920#.fr4r286v5)
 * [Developing Angular2 Dart Asset Services, Part 2](https://medium.com/@mike_99824/developing-angular2-dart-asset-services-part-2-481336b36cf8#.hdt018j4l)