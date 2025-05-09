  part of 'product_cubit.dart';

  @immutable
  sealed class ProductState {}

  final class ProductInitial extends ProductState {}

  final class ProductLoadingState extends ProductState {}

  final class ProductSuccessState extends ProductState {}

  final class ProductErrorState extends ProductState {
    final String message;

    ProductErrorState(this.message);
  }
