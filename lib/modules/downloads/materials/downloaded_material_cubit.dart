import 'package:bloc/bloc.dart';

import '../../../core/sqlite.dart';
import 'downloaded_material_state.dart';
import 'downloed_material_model.dart';

class DownloadedMaterialCubit extends Cubit<DownloadedMaterialState> {
  DownloadedMaterialCubit() : super(DownloadedMaterialInit());

  List<DownloadedMaterialModel> materials = [];

  void getSubjects() async{
    emit(DownloadedMaterialLoading());

    final subjects = await SqliteHelper.getSubjects();
    for(var subject in subjects){
      print('subject is $subject');
      materials.add(DownloadedMaterialModel(subject['subject_id'], subject['subject_name'],null));
    }
    emit(DownloadedMaterialSuccess());
  }

   void getUnits(int subjectId) async{
    emit(DownloadedMaterialLoading());
    final units = await SqliteHelper.getUnits(subjectId);
    for(var unit in units){
      materials.add(DownloadedMaterialModel(unit['unit_id'], unit['unit_name'],null));
    }
    emit(DownloadedMaterialSuccess());
  }



  void getLessons(int unitId) async{
    emit(DownloadedMaterialLoading());
    final lessons = await SqliteHelper.getLessons(unitId);
    for(var lesson in lessons){
      materials.add(DownloadedMaterialModel(lesson['id'],lesson['lesson_name'],lesson['unit_id']));
    }
    emit(DownloadedMaterialSuccess());
  }
}

enum DownloadedMaterialType{
  lesson,
  unit,
  subject
}
