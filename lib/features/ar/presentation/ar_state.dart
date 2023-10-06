import 'package:get/get.dart';

import '../../../app/app/app_state.dart';

class ARState extends GetxController {
  final PageStatus pageStatus;
  ARState({
    this.pageStatus = PageStatus.loading,
  });
  @override
  void update([List<Object>? ids, bool condition = true]) {
    // TODO: implement update
    super.update(ids, condition);
  }
}
