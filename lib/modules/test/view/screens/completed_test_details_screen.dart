import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/modules/test/cubit/test_cubit.dart';
import 'package:salamat/modules/test/models/result.dart';
import 'package:salamat/modules/test/models/test.dart';
import 'package:salamat/modules/test/view/widgets/final_result_card.dart';
import 'package:salamat/modules/test/view/widgets/read_only_question_card.dart';
import 'package:salamat/widgets/app_scaffold.dart';
import 'package:salamat/widgets/top_banner.dart';

class CompletedTestDetailsScreen extends StatelessWidget {
  const CompletedTestDetailsScreen(
      {super.key, required this.test, required this.testCubit});
  final Test test;
  final TestCubit testCubit;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: test.name,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TopBanner(
                        title: 'مرات المحاولة',
                        value: test.attemptCount.toString()),
                    TopBanner(
                        title: 'النتيجة السابقة',
                        value:
                            "${test.latestStudentExam!.degree}/${test.latestStudentExam!.examDegree}"),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              SliverList.separated(
                itemCount: test.questions.length,
                separatorBuilder: (context, index) => SizedBox(height: 15.h),
                itemBuilder: (context, index) => ReadOnlyQuestionCard(
                    test: test,
                    color: AppColors.appColors[index % 4].withAlpha(180),
                    padding: EdgeInsets.all(12.w),
                    question: test.questions[index]),
              ),
              SliverToBoxAdapter(
                child: FinalResultCard(
                    result: Result(
                  studentDegree: test.latestStudentExam!.degree,
                  examDegree: test.latestStudentExam!.examDegree,
                  examPassPercentage: '',
                  pass: test.latestStudentExam!.pass,
                )),
              )
            ],
          ),
        ));
  }
}
