import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:salamat/apis/exception_handler.dart';
import 'package:salamat/apis/urls.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/modules/teachers/models/teacher.dart';
import 'package:salamat/modules/teachers/models/teachers_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'teachers_state.dart';

class TeachersCubit extends Cubit<TeachersState> {
  TeachersCubit() : super(TeachersInitial());

  List<Teacher> teachers = [];
  int page = 1;
  final RefreshController refreshController = RefreshController();

  Future<void> getTeachers() async {
    if (page == 1) {
      teachers.clear();
      emit(GetTeachersLoading());
    }

    try {
      final response =
          await Network.getData(url: "${Urls.teachers}?page=$page");

      final TeachersResponse teachersResponse =
          TeachersResponse.fromJson(response.data);

      if (page > 1) {
        teachers.addAll(teachersResponse.data.teachers);
        if (teachersResponse.data.teachers.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        teachers = teachersResponse.data.teachers;
        refreshController.loadComplete();
      }
      page = teachersResponse.data.currentPage + 1;

      emit(GetTeachersSuccess());
    } on DioException catch (error) {
      emit(GetTeachersError(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetTeachersError(message: unknownError()));
    }
  }

  late Teacher teacherDetails;
  Future<void> getTeacherDetails({required int teacherId}) async {
    emit(GetTeacherDetailsLoading());
    try {
      final response =
          await Network.getData(url: "${Urls.teachers}/$teacherId");
      final Teacher teacherDetailsResponse =
          Teacher.fromJson(response.data['data']);
      teacherDetails = teacherDetailsResponse;
      emit(GetTeacherDetailsSuccess());
    } on DioException catch (error) {
      emit(GetTeacherDetailsError(message: exceptionsHandle(error: error)));
    }
    catch (error) {
      emit(GetTeacherDetailsError(message: unknownError()));
    }
  }
}
