import 'package:angular2/core.dart';
import 'package:logging/logging.dart';

@Injectable()
class LoggerService {
  final Logger _logger = new Logger("app");

  Logger get logger => _logger;

}
