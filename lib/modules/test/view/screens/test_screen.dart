import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/test/cubit/exam_cubit.dart';
import 'package:my_project_new/modules/test/view/widgets/counters_squres.dart';
import 'package:my_project_new/modules/test/view/widgets/test_headar.dart';
import 'package:my_project_new/modules/test/view/widgets/final_result_card.dart';
import 'package:my_project_new/modules/test/view/widgets/questions_list.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/custom_button.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate('test', context),
      backgroundColor: AppColors.SECONDRY,
      appBarBorderRadius: BorderRadius.zero,
      body: BlocProvider(
        create: (context) => ExamCubit(),
        child: BlocBuilder<ExamCubit, ExamState>(
          builder: (context, state) {
            final ExamCubit examCubit = context.read<ExamCubit>();
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Images.examBack,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomScrollView(
                slivers: [
                  const HeaderImage(),
                  const CountersSqures(),
                  QuestionsList(examCubit: examCubit),
                  if (examCubit.isSubmitted) const FinalResultCard(score: 70),
                  SubmitButton(
                    examCubit: examCubit,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.examCubit,
  });
  final ExamCubit examCubit;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: CustomButton(
          borderRadius: BorderRadius.circular(15.r),
          backgroundColor: AppColors.LIGHTGRAY,
          buttonStyle: titilliumBold.copyWith(color: AppColors.PRIMARY),
          onPressed: () {
            examCubit.submitExam();
          },
          label: 'تحقق من الإجابات',
        ),
      ),
    );
  }
}
