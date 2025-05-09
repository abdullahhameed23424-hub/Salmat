import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'points_record_state.dart';

class PointsRecordCubit extends Cubit<PointsRecordState> {
  PointsRecordCubit() : super(PointsRecordInitial());
}
