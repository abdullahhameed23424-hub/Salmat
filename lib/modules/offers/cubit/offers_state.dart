part of 'offers_cubit.dart';

@immutable
sealed class OffersState {}

final class OffersInitial extends OffersState {}

final class OffersLoadingState extends OffersState {}

final class OffersSuccessState extends OffersState {}

final class OffersErrorState extends OffersState {
  final String message;

  OffersErrorState({required this.message});
}
