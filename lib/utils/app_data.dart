import 'package:package_info_plus/package_info_plus.dart';

export 'package:package_info_plus/package_info_plus.dart';

class AppVersion {
  static Future<PackageInfo> getPackageInfo() {
    return PackageInfo.fromPlatform();
  }
}
