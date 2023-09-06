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
        return 'AR Zoo Explorers';
      case Flavor.PRODUCTION:
        return 'AR Zoo Explorers';
      case Flavor.STAGGING:
        return 'AR Zoo Explorers';
      default:
        return 'title';
    }
  }
}
