import 'package:get/get.dart';

import '../../../app/app/app_state.dart';

class ARState extends GetxController {
  final PageStatus pageStatus;
  ARState({
    this.pageStatus = PageStatus.loading,
  });
}
