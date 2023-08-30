// ignore_for_file: constant_identifier_names

enum FontFamily {
  Roboto,
  RoundedMplus1c
}

extension FontFamilyExtension on FontFamily {
  String get name {
    switch (this) {
      case FontFamily.Roboto:
        return 'Roboto';
      case FontFamily.RoundedMplus1c:
        return 'RoundedMplus1c';
    }
  }
}
