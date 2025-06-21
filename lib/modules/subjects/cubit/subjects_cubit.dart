import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:salamat/apis/exception_handler.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/apis/urls.dart';
import 'package:salamat/modules/subjects/models/subject.dart';
import 'package:salamat/modules/subjects/models/subjects_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../helper/reponse_cacher.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit() : super(SubjectsInitial());

  final RefreshController refreshController = RefreshController();
  int page = 1;
  late SubjectsResponse subjectsResponse;
  List<Subject> subjects = [];
  String headerText = '';
  String headerImage = '';
  Future<void> getSubjects({required int sectionId}) async {


    if (page == 1) {
      emit(GetSubjectsLoadingState());
    }
    String key = "${Urls.sections}/$sectionId?type=subjects&page=1";

    try{
      if(ResponseCacher.hasCache(key)) {
        subjectsResponse = SubjectsResponse.fromJson(ResponseCacher.getCache(key));

        if(page == 1){
          subjects = subjectsResponse.original.data.seubjects;
          headerImage = subjectsResponse.original.section.image;
          headerText = subjectsResponse.original.section.description;
        }
        emit(GetSubjectsSuccessState());
      }
    }catch(error){
      //
    }
    try {
      Response response = await Network.getData(
        url: "${Urls.sections}/$sectionId?type=subjects&page=$page",
      );
      subjectsResponse = SubjectsResponse.fromJson(response.data);

      if (page > 1) {
        subjects.addAll(subjectsResponse.original.data.seubjects);

        if (subjectsResponse.original.data.seubjects.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        subjects = subjectsResponse.original.data.seubjects;
        headerImage = subjectsResponse.original.section.image;
        headerText = subjectsResponse.original.section.description;
      }
      if(page == 1){
      ResponseCacher.cache(key, response.data);
      }

      page = subjectsResponse.original.data.currentPage + 1;
      emit(GetSubjectsSuccessState());
    } on DioException catch (error) {
      if(error.type == DioExceptionType.badResponse){
        ResponseCacher.removeCache(key);
        emit(GetSubjectsErrorState(message: exceptionsHandle(error: error)));
      }else{
        if(ResponseCacher.hasCache(key) == false){
          emit(GetSubjectsErrorState(message: unknownError()));
        }
      }
    } catch (error) {
      emit(GetSubjectsErrorState(message: unknownError()));
    }
  }
}
