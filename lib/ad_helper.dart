import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // Test AdMob Ad Unit ID
      return 'ca-app-pub-3940256099942544/6300978111';
      // Deployment AdMob Ad Unit ID
      // return 'ca-app-pub-7923538640396249/3972503909';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
