import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/app_localization.dart';
import 'package:my_project_new/localization/custom_delegate.dart';
import 'package:my_project_new/localization/language_model.dart';

String translate(String key, BuildContext context, {List<String>? args}) {
  String translation = AppLocalization.of(context).translate(key);

  if (args != null) {
    for (int i = 0; i < args.length; i++) {
      translation = translation.replaceAll('{$i}', args[i]);
    }
  }
  return translation;
}

final List<LanguageModel> languages = [
  LanguageModel(languageName: 'English', languageCode: 'en', flag: Images.gb),
  LanguageModel(languageName: 'العربية', languageCode: 'ar', flag: Images.ar),
];

List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
  AppLocalization.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  FallbackLocalizationDelegate()
];
