import 'package:flutter/foundation.dart';

import 'flavors.dart';
import 'main_page.dart';

void main() {
  if (kDebugMode) {
    // final proxy = CustomProxy(ipAddress: "172.17.0.59", port: 8888, allowBadCertificates: true);
    // proxy.enable();
  }
  F.appFlavor = Flavor.DEVELOP;
  runMain();
}
