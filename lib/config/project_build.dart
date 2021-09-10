
import 'package:package_info_plus/package_info_plus.dart';

class ProjectBuild {
  static late PackageInfo _packageInfo;

  static Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  static String get appVersion => _packageInfo.version;

  static String get buildVersion => _packageInfo.buildNumber;
}