import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:salamat/apis/exception_handler.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/apis/urls.dart';
import 'package:salamat/modules/info/models/info_response.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(InfoInitial());

  late InfoResponse infoResponse;

  Future<void> getInfo() async {
    emit(GetInfoLoadingState());

    try {
      final response = await Network.getData(url: Urls.infos);

      infoResponse = InfoResponse.fromJson(response.data);

      emit(GetInfoSuccessState());
    } on DioException catch (e) {
      emit(GetInfoErrorState(message: exceptionsHandle(error: e)));
    } catch (e) {
      emit(GetInfoErrorState(message: unknownError()));
    }
  }
}
