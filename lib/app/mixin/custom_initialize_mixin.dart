import 'package:ar_zoo_explorers/core/network/gpt_service/gpt_service.dart';
import 'package:ar_zoo_explorers/di/injector.dart';

mixin CustomInitializeMixin {
  void initGPTService() async {
    getIt<GptService>().init(apiKeys: [
      "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"
    ]);
  }
}
