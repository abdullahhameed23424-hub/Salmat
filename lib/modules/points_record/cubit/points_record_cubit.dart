import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:salamat/apis/exception_handler.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/apis/urls.dart';
import 'package:salamat/modules/points_record/models/points_response.dart';

part 'points_record_state.dart';

class PointsRecordCubit extends Cubit<PointsRecordState> {
  PointsRecordCubit() : super(PointsRecordInitial());

  late PointsResponse pointsResponse;
  Future<void> getPoints() async {
    emit(PointsRecordLoadingState());
    try {
      final Response response = await Network.getData(url: Urls.points);
      pointsResponse = PointsResponse.fromJson(response.data);

      emit(PointsRecordSuccessState());
    } on DioException catch (error) {
      emit(PointsRecordErrorState(message: exceptionsHandle(error: error)));
    } catch (_) {
      emit(PointsRecordErrorState(message: unknownError()));
    }
  }
}
