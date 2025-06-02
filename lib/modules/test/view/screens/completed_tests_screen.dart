import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/test/cubit/test_cubit.dart';
import 'package:my_project_new/modules/test/view/widgets/completed_test_card.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/try_again.dart';

class CompletedTestsScreen extends StatelessWidget {
  const CompletedTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.white,
      title: translate('completed_tests', context),
      body: BlocProvider(
        create: (context) => TestCubit()..getCompletedTests(),
        child: BlocBuilder<TestCubit, TestState>(
          builder: (context, state) {
            print("state:${state}");
            final TestCubit testCubit = context.read<TestCubit>();
            if (state is GetCompletedTestsLoadingState) {
              return const AppLoading();
            }
            if (state is GetCompletedTestsErrorState) {
              return TryAgain(
                  onTap: () {
                    testCubit.getCompletedTests();
                  },
                  message: state.message);
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Image.asset(Images.completedTests),
                      )),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    child: Text(
                      translate('completed_tests', context),
                      style: titilliumBold.copyWith(
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  sliver: SliverGrid.builder(
                    itemCount: testCubit.tests.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 25.h,
                    ),
                    itemBuilder: (context, index) => CompletedTestCard(
                        test: testCubit.tests[index], testCubit: testCubit),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
