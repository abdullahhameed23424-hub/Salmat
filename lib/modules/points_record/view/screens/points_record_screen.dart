import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/points_record/cubit/points_record_cubit.dart';
import 'package:my_project_new/modules/points_record/view/widgets/getting_points_sheet.dart';
import 'package:my_project_new/modules/points_record/view/widgets/points_card.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/widgets/try_again.dart';

class PointsRecordScreen extends StatelessWidget {
  const PointsRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarBorderRadius: BorderRadius.zero,
      title: translate("my_points", context),
      body: BlocProvider(
        create: (context) => PointsRecordCubit()..getPoints(),
        child: BlocBuilder<PointsRecordCubit, PointsRecordState>(
          builder: (context, state) {
            final PointsRecordCubit pointsRecordCubit =
                context.read<PointsRecordCubit>();
            if (state is PointsRecordLoadingState) {
              return const AppLoading();
            }
            if (state is PointsRecordErrorState) {
              return TryAgain(
                  onTap: () {
                    pointsRecordCubit.getPoints();
                  },
                  message: state.message);
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      height: 210.h,
                      width: 1.sw,
                      decoration:
                          const BoxDecoration(color: AppColors.SECONDRY),
                      child: Row(
                        spacing: 5.w,
                        children: <Widget>[
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(right: 16.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 15.h),
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 10,
                                  children: <Widget>[
                                    Text(
                                      translate('total_points_title', context),
                                      style: titilliumBold.copyWith(
                                          decoration: TextDecoration.underline),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      translate(
                                          'greeting_message',
                                          args: [
                                            pointsRecordCubit
                                                .pointsResponse.data.totlaPoints
                                          ],
                                          context),
                                      style: titilliumBold.copyWith(
                                          color: AppColors.WHITE, height: 2),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          FadeIn(
                              delay: const Duration(milliseconds: 500),
                              child:
                                  Image.asset(Images.scoreImage, width: 180.w)),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                    child: CustomButton(
                      borderRadius: BorderRadius.circular(15),
                      label: translate("how_get_pints", context),
                      onPressed: () {
                        GettingPointsSheet.show(context);
                      },
                      backgroundColor: AppColors.PURPLE_LIGHT,
                    ),
                  ),
                ),
                if(pointsRecordCubit
                    .pointsResponse.data.pointsList.isNotEmpty)
                SliverList.separated(
                  itemCount:
                      pointsRecordCubit.pointsResponse.data.totlaPoints.length,
                  itemBuilder: (context, index) => PointsCard(
                      points: pointsRecordCubit
                          .pointsResponse.data.pointsList[index]),
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
