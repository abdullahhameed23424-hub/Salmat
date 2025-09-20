import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/test/cubit/test_cubit.dart';
import 'package:salamat/modules/test/models/test_response.dart';
import 'package:salamat/modules/test/view/widgets/question_card.dart';
import 'package:salamat/modules/lessons/view/widgets/explanation_video.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/widgets/app_scaffold.dart';
import 'package:salamat/widgets/cached_image.dart';
import 'package:salamat/widgets/image_viewer.dart';

class QuestionExplanationScreen extends StatelessWidget {
  const QuestionExplanationScreen(
      {super.key, required this.examCubit, required this.question});
  final TestCubit examCubit;
  final Question question;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: translate('explanation', context),
        body: Stack(
          children: [
            Positioned(
                bottom: 20.h,
                left: 0,
                child: Image.asset(Images.explanationScreenBg, width: 270.w)),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              children: [
                Row(
                  spacing: 12.w,
                  children: <Widget>[
                    Image.asset(Images.explanationIcon, width: 72.w),
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
                    test: examCubit.test,
                    padding: EdgeInsets.all(8.w),
                    question: question,
                    examCubit: examCubit),
                SizedBox(height: 10.h),
                Text(
                  translate('question_explanation', context),
                  style: titilliumBold.copyWith(color: AppColors.PRIMARY),
                ),
                SizedBox(height: 10.h),
                if (question.note != "")
                  HtmlWidget(
                    question.note!,
                    textStyle: titilliumRegular,
                  ),
                Divider(indent: 77.w, endIndent: 77.w, height: 40.h),
                if (question.video != "") ...[
                  ExplanationVideo(url: question.video),
                  Divider(indent: 77.w, endIndent: 77.w, height: 40.h),
                ],
                if (question.image.isNotEmpty)
                  InkWell(
                    onTap: () {
                      pushTo(
                          context: context,
                          toPage: ImageViewer(imageUrl: question.image));
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          boxShadow: boxShadow,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      width: 1.sw,
                      child: Hero(
                        tag: question.image,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: CachedImage(
                            image: question.image,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ));
  }
}
