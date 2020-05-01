import 'dart:io';

import 'package:flutter/material.dart';

class Common {
  var admobAppId = 'ca-app-pub-4800441463353851~7511567746';
  var bannerUnitId = 'ca-app-pub-4800441463353851/5476431346';
  var photoDirWA = '/storage/emulated/0/WhatsApp/Media/.Statuses';
  var photoDirWAB = '/storage/emulated/0/WhatsApp Business/Media/.Statuses';
  var videoDirWA = '/storage/emulated/0/WhatsApp/Media/.Statuses';
  var videoDirWAB = '/storage/emulated/0/WhatsApp Business/Media/.Statuses';

  double getSmartBannerHeight(MediaQueryData mediaQuery) {
    if (Platform.isAndroid) {
      if (mediaQuery.size.height > 720) return 90.0;
      if (mediaQuery.size.height > 400) return 50.0;
      return 0.0;
    }

    if (Platform.isIOS) {
      // if (iPad) return 90.0;
      if (mediaQuery.orientation == Orientation.portrait) return 50.0;
      return 32.0;
    }
    // No idea, just return a common value.
    return 0.0;
  }
}
