import 'dart:collection';

import 'package:ar_zoo_explorers/app/languages/resources/en_us.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/storage_helper.dart';
import 'resources/vi_vn.dart';

class LocalizationService extends Translations {
  // locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static final locale = _getLocaleFromLanguage();

  // fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static const fallbackLocale = Locale('en', 'US');

  // language code của những locale được support
  static final langCodes = ['vi', 'en'];

  // các Locale được support
  static final locales = [
    const Locale('vi', 'VN'),
    const Locale('en', 'EN'),
  ];

  // cái này là Map các language được support đi kèm với mã code của lang đó: cái này dùng để đổ data vào Dropdownbutton và set language mà không cần quan tâm tới language của hệ thống
  static final langs = LinkedHashMap.from({
    'vi': 'Tiếng Việt',
    'en': 'Tiếng Anh',
  });

  // function change language nếu bạn không muốn phụ thuộc vào ngôn ngữ hệ thống
  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);

    StorageHelper.setLanguageCode(langCode);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'vi_VN': vi_vn,
        'en_EN': en_us,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ??
        StorageHelper.getLanguageCode() ??
        Get.deviceLocale?.languageCode;
    return locales.firstWhere(
      (element) => element.languageCode == lang,
      orElse: () => Get.locale!,
    );
  }
}

extension LocaleExt on Locale {
  String get displayCountry {
    if (countryCode == "US") {
      return "EN";
    }
    return countryCode ?? "";
  }
}

extension LocaleExt1 on Locale {
  static const Map<String, String> localeDisplayNames = {
    'vi': 'Vietnamese (VN)',
  };

  String get displayLanguageCountry {
    final languageCountry = LocaleExt1.localeDisplayNames[languageCode] ?? '';
    return languageCountry;
  }
}

extension LocaleExt2 on String {
  static const Map<String, String> localeDisplayNames = {
    'vi_VN': 'Vietnamese (VN)',
  };

  String get displayLanguageCountry {
    final languageCountry = LocaleExt2.localeDisplayNames[this] ?? '';
    return languageCountry;
  }
}
