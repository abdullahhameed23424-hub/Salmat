import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/modules/test/cubit/test_cubit.dart';
import 'package:my_project_new/modules/test/models/option.dart';
import 'package:my_project_new/modules/test/models/result.dart';
import 'package:my_project_new/modules/test/models/test_response.dart';
import 'package:my_project_new/modules/test/view/widgets/final_result_card.dart';
import 'package:my_project_new/modules/test/view/widgets/question_card.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/top_banner.dart';

class CompletedTestDetailsScreen extends StatelessWidget {
  const CompletedTestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: "أساسيات 1 في التحليل",
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TopBanner(title: 'مرات المحاولة', value: '10'),
                    TopBanner(title: 'النتيجة السابقة', value: '70'),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              SliverList.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => SizedBox(height: 15.h),
                itemBuilder: (context, index) => QuestionCard(
                    color: AppColors.appColors[index % 4].withAlpha(180),
                    //  AppColors.SECONDRY.withAlpha(210),
                    padding: EdgeInsets.all(12.w),
                    question: Question(
                      id: 1,
                     
                      degree: 1,
                      video: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                      image: 'https://via.placeholder.com/150',
                      chosenAndTrue: true,
                      text: 'المقدار 2x(x+3)-(x+3) يساوي:',
                      options: [
                        Option(
                            id: 1,
                            name: '2(x+1)(x+3)',
                            isTrue: true,
                            isChosen: true),
                        Option(
                            id: 2,
                            name: '2x+3',
                            isTrue: false,
                            isChosen: false),
                        Option(
                            id: 3,
                            name: 'x(2x+3)',
                            isTrue: false,
                            isChosen: false),
                      ],
                    ),
                    examCubit: TestCubit()..isSolving = true),
              ),
              FinalResultCard(
                  result: Result(
                      studentDegree: '20',
                      examDegree: '100',
                      examStudentDegree: '20',
                      examPassPercentage: '70',
                      pass: true))
            ],
          ),
        ));
  }
}
