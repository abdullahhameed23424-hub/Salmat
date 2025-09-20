import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/offers/cubit/offers_cubit.dart';
import 'package:salamat/modules/offers/view/widgets/offer_card.dart';
import 'package:salamat/widgets/app_footer.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/app_scaffold.dart';
import 'package:salamat/widgets/no_data.dart';
import 'package:salamat/widgets/refresher_header.dart';
import 'package:salamat/widgets/try_again.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate("offers", context),
      body: BlocProvider(
        create: (context) => OffersCubit()..getOffers(),
        child: BlocBuilder<OffersCubit, OffersState>(
          builder: (context, state) {
            final offersCubit = context.read<OffersCubit>();
            if (state is GetOffersLoadingState) {
              return const AppLoading();
            }
            if (state is GetOffersErrorState) {
              return TryAgain(
                  onTap: () {
                    offersCubit.getOffers();
                  },
                  message: state.message);
            }
            if (offersCubit.offers.isEmpty) {
              return const NoData();
            }
            return SmartRefresher(
              controller: offersCubit.refreshController,
              enablePullUp: true,
              enablePullDown: true,
              onRefresh: () {
                offersCubit.page = 1;
                offersCubit.getOffers();
              },
              footer: const AppFooter(),
              onLoading: () {
                offersCubit.getOffers();
              },
              header: const AppRefresherHeader(),
              child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.w,
                    horizontal: 12.h,
                  ),
                  itemCount: offersCubit.offers.length,
                  separatorBuilder: (context, index) => SizedBox(height: 25.h),
                  itemBuilder: (context, index) => ZoomIn(
                      delay:
                          Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
                      child: OfferCard(offer: offersCubit.offers[index]))),
            );
          },
        ),
      ),
    );
  }
}
