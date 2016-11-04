import 'package:angular2/core.dart';
import 'package:in_tallinn/conf/app_config.dart';
import 'package:logging/logging.dart';
import "package:console_log_handler/console_log_handler.dart";
import 'package:in_tallinn/logger/logger_service.dart';

@Injectable()
class ConsoleLogger extends Object with LoggerService {
  static const Level _defaultLevel = Level.INFO;
  AppConfig _conf;

  ConsoleLogger(@Inject(AppConfig) this._conf) {
    configLogging();
  }

  void configLogging() {
    hierarchicalLoggingEnabled = true;
    if (_conf.logLevel != null) {
      Logger.root.level = _conf.logLevel;
    } else {
      Logger.root.level = _defaultLevel;
    }
    new Logger("app.motd")
      ..level = Level.ALL;
    Logger.root.onRecord.listen(new LogConsoleHandler());
  }

}
