import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class CustomLocalizations {
  CustomLocalizations(this.locale);

  final Locale locale;

  static CustomLocalizations of(BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations)!;
  }

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    try {
      String jsonString = await rootBundle
        .loadString('assets/lang/${locale.languageCode}.json');

      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
      return true;
    } catch (e) {
      print('Error loading localization data: $e');
      return false;
    }
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  static const LocalizationsDelegate<CustomLocalizations> delegate =
      _CustomLocalizationsDelegate();
}

class _CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  const _CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<CustomLocalizations> load(Locale locale) async {
    CustomLocalizations localizations = CustomLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_CustomLocalizationsDelegate old) => false;
}
