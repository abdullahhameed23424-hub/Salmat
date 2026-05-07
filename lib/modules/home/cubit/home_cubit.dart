import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamat/apis/exception_handler.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/apis/urls.dart';
import 'package:salamat/modules/comments/models/comment.dart';
import 'package:salamat/modules/home/models/home_response.dart';
import 'package:salamat/modules/offers/models/offer.dart';
import 'package:salamat/modules/sections/models/section.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  late HomeResponse homeResponse;
  final RefreshController refreshController = RefreshController();
  List<Section> sections = [];
  List<Offer> offers = [];
  List<Comment> platformComments = [];
  String libraryImage = "";

  Future<void> getHomeInfo() async {
    emit(GetHomeLoadingState());

    try {
      Response response = await Network.getData(url: Urls.home);

      homeResponse = HomeResponse.fromJson(response.data);

      sections = homeResponse.data.sections.sections;
      offers = homeResponse.data.offers;
      platformComments = homeResponse.data.platformComments;
      libraryImage = homeResponse.data.libraryInfo?.image ?? "";

      if (isClosed) return;
      emit(GetHomeSuccessState());
    } on DioException catch (error) {
      emit(GetHomeErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      if (isClosed) return;
      emit(GetHomeErrorState(message: unknownError()));
    } finally {
      refreshController.refreshCompleted();
    }
  }
}
