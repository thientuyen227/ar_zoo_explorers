enum Flavor {
  DEVELOP,
  PRODUCTION,
  STAGGING,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEVELOP:
        return 'SpeakEasyAI - AI Chatbot';
      case Flavor.PRODUCTION:
        return 'SpeakEasyAI - AI Chatbot';
      case Flavor.STAGGING:
        return 'SpeakEasyAI - AI Chatbot';
      default:
        return 'title';
    }
  }
}
