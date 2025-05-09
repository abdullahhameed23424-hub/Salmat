import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/comments/models/comment.dart';
import 'package:my_project_new/modules/home/models/home_response.dart';
import 'package:my_project_new/modules/offers/models/offer.dart';
import 'package:my_project_new/modules/subjects/models/subject.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  late HomeResponse homeResponse;
  final RefreshController refreshController = RefreshController();

  Future<void> getHomeInfo() async {
    emit(GetHomeLoadingState());

    try {
      Response response = await Network.getData(
        url: Urls.home,
      );

      homeResponse = HomeResponse.fromJson(response.data);
      emit(GetHomeSuccessState());
    } on DioException catch (error) {
      emit(GetHomeErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetHomeErrorState(message: unknownError()));
    } finally {
      refreshController.refreshCompleted();
    }
  }
}
