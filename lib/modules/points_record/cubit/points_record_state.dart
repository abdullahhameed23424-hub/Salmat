part of 'points_record_cubit.dart';

@immutable
sealed class PointsRecordState {}

final class PointsRecordInitial extends PointsRecordState {}

final class PointsRecordLoadingState extends PointsRecordState {}

final class PointsRecordSuccessState extends PointsRecordState {}

final class PointsRecordErrorState extends PointsRecordState {
  final String message;

  PointsRecordErrorState({required this.message});
}
