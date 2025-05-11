import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  LessonsCubit() : super(LessonsInitial());

  static const List<String> lessonButtonsTitles = [
    "images",
    "attachments",
  ];
  static int _selectedButton = 0;
  static int get selectedButton => _selectedButton;
  static void changeSelectedButton({required int index}) {
    _selectedButton = index;
  }
}
