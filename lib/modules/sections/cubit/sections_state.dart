part of 'sections_cubit.dart';

@immutable
sealed class SectionsState {}

final class SectionsInitial extends SectionsState {}

final class GetSectionsLoadingState extends SectionsState {}

final class GetSectionsSuccessState extends SectionsState {}

final class GetSectionsErrorState extends SectionsState {
  final String message;

  GetSectionsErrorState({required this.message});
}
