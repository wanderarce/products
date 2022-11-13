import 'package:flutter/foundation.dart';

class PlatformService {
  bool isMobilePlatform() {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }
}
