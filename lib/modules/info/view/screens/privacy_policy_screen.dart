import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/animation/fade_in_animation.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/info/cubit/info_cubit.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/app_scaffold.dart';
import 'package:salamat/widgets/try_again.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key, required this.infoCubit});

  final InfoCubit infoCubit;

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    if (widget.infoCubit.state is InfoInitial) {
      widget.infoCubit.getInfo();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarBorderRadius: BorderRadius.zero,
      title: translate('privacy_policy', context),
      body: BlocProvider.value(
        value: widget.infoCubit,
        child: BlocBuilder<InfoCubit, InfoState>(
          builder: (context, state) {
            final InfoCubit infoCubit = context.read<InfoCubit>();
            if (state is GetInfoLoadingState) {
              return const AppLoading();
            }
            if (state is GetInfoErrorState) {
              return TryAgain(
                  onTap: () {
                    infoCubit.getInfo();
                  },
                  message: state.message);
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20.h,
                children: <Widget>[
                  FadeInDown(
                    child: Image.asset(
                      Images.privacyPolicyTop,
                      width: 1.sw,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'سياسة الخصوصية لتطبيق سلامات',
                          style: titilliumBold,
                        ),
                        Text(
                          infoCubit.infoResponse.privacyPolicy.text,
                          style: titilliumRegular.copyWith(height: 2),
                        ),
                      ],
                    ),
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
