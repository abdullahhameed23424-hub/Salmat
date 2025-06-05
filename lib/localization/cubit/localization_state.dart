part of 'localization_cubit.dart';

@immutable
sealed class LocalizationState {}

final class LocalizationInitial extends LocalizationState {}

 
 
final class InitDefaultLocaleState extends LocalizationState {}
final class ChangeLocaleState extends LocalizationState {}
 
