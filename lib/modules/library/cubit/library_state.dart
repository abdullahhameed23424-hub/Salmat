part of 'library_cubit.dart';

@immutable
sealed class LibraryState {}

final class LibraryInitial extends LibraryState {}

final class LibraryLoadingState extends LibraryState {}

final class LibrarySuccessState extends LibraryState {}

final class LibraryErrorState extends LibraryState {
  final String message;

  LibraryErrorState({required this.message});
}
