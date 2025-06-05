part of 'offers_cubit.dart';

@immutable
sealed class OffersState {}

final class OffersInitial extends OffersState {}

final class GetOffersLoadingState extends OffersState {}

final class GetOffersSuccessState extends OffersState {}

final class GetOffersErrorState extends OffersState {
  final String message;

  GetOffersErrorState({required this.message});
}
