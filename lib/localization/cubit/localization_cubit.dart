import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/helper/app_sharedPreferance.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  Locale? _appLoacale;

  Locale? get appLocale => _appLoacale;

  void init({required BuildContext context}) {
    if (AppSharedPreferences.haslocale) {
      _appLoacale = Locale(AppSharedPreferences.getLocale);
    } else {
      _appLoacale = Localizations.localeOf(context);
      AppSharedPreferences.saveLocale(_appLoacale?.languageCode ?? "ar");
    }
    emit(InitDefaultLocaleState());
  }

  void changeLocale({required Locale locale}) {
    if (locale.languageCode != _appLoacale?.languageCode) {
      _appLoacale = locale;
      AppSharedPreferences.saveLocale(locale.languageCode);
      Network.init();
      emit(ChangeLocaleState());
    }
  }
}
