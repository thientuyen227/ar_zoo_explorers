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
        return 'AR PreShcool Education';
      case Flavor.PRODUCTION:
        return 'AR PreShcool Education';
      case Flavor.STAGGING:
        return 'AR PreShcool Education';
      default:
        return 'title';
    }
  }
}
