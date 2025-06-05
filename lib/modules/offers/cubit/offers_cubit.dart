import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/offers/models/offers_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());

  List offers = [];

  int page = 1;

  RefreshController refreshController = RefreshController();

  OffersResponse? offersResponse;

  Future<void> getOffers() async {
    Response response;
    try {
      if (page == 1) {
        emit(GetOffersLoadingState());
      }

      response = await Network.getData(url: "${Urls.offers}?page=$page");
      offersResponse = OffersResponse.fromJson(response.data);

      if (page > 1) {
        offers.addAll(offersResponse!.data);
        if (offersResponse!.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        offers = offersResponse!.data;
        refreshController.loadComplete();
      }
      page = offersResponse!.currentPage + 1;

      emit(GetOffersSuccessState());
    } on DioException catch (error) {
      emit(GetOffersErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetOffersErrorState(message: unknownError()));
    }
  }
}
