import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/test/cubit/exam_cubit.dart';
import 'package:my_project_new/modules/test/models/question.dart';
import 'package:my_project_new/modules/test/view/widgets/question_card.dart';
import 'package:my_project_new/modules/lessons/view/widgets/explanation_video.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';

class QuestionExplanationScreen extends StatelessWidget {
  const QuestionExplanationScreen({super.key, required this.examCubit});
  final ExamCubit examCubit;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: translate('explanation', context),
        body: Stack(
          children: [
            Positioned(
                bottom: 20.h,
                left: 0,
                child: Image.asset(
                  Images.explanationScreenBg,
                  width: 270.w,
                )),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              children: [
                Row(
                  spacing: 12.w,
                  children: <Widget>[
                    Image.asset(
                      Images.explanationIcon,
                      width: 72.w,
                    ),
                    SizedBox(
                      width: 1.sw - 72.w - 12.w - 32.w,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                                text:
                                    'لا تقلق في حال واجهت صعوبة في هذا السؤال لأن'),
                            TextSpan(
                              text: ' سلامات',
                              style: titilliumRegular.copyWith(
                                  color: AppColors.PRIMARY),
                            ),
                            const TextSpan(text: ' سيساعدك في حله ..'),
                          ],
                        ),
                        style: titilliumRegular,
                      ),
                    ),
                  ],
                ),
                Divider(
                  indent: 76.w,
                  endIndent: 76.w,
                  height: 40,
                ),
                Text(
                  translate('question_text', context),
                  style: titilliumBold.copyWith(color: AppColors.PRIMARY),
                ),
                SizedBox(height: 10.h),
                QuestionCard(
                    padding: EdgeInsets.all(8.w),
                    question: Question(
                      correctAnswerIndex: 1,
                      text: 'المقدار 2x(x+3)-(x+3) يساوي:' * 3,
                      options: ['2(x+1)(x+3)' * 3, '2x+3' * 2, 'x(2x+3)' * 5],
                    ),
                    examCubit: examCubit),
                SizedBox(height: 10.h),
                Text(
                  translate('question_explanation', context),
                  style: titilliumBold.copyWith(color: AppColors.PRIMARY),
                ),
                SizedBox(height: 10.h),
                Text(
                  'لنبدأ بتبسيط المقدار  2x(x+3) - (x+3) ثم نبدأ بتوزبع العوامل ثم نجمع الحدود، والآن، نريد أن نرى إذا كان يمكننا كتابة  2x² + 5x - 3  بشكل عامل. لنبحث عن العوامل التي تعطي نفس المقدار',
                  style: titilliumRegular,
                ),
                Divider(indent: 77.w, endIndent: 77.w, height: 40.h),
                const ExplanationVideo(),
                Divider(indent: 77.w, endIndent: 77.w, height: 40.h),
                AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.DARK_GREY,
                            borderRadius: BorderRadius.circular(10)),
                        width: 1.sw,
                        child: Image.asset(Images.arabic)))
              ],
            ),
          ],
        ));
  }
}
