import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/info/cubit/info_cubit.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/custom_button.dart';
import 'package:salamat/widgets/try_again.dart';
import 'package:share_plus/share_plus.dart';

class ShareAppBtn extends StatelessWidget {
  const ShareAppBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InfoCubit>(
      create: (context) => InfoCubit()..getInfo(),
      child: BlocBuilder<InfoCubit, InfoState>(
        builder: (context, state) {
          final InfoCubit cubit = context.read<InfoCubit>();
          if (state is GetInfoLoadingState) {
            return const AppLoading();
          } else if (state is GetInfoErrorState) {
            return TryAgain(
              withImage: false,
              onTap: cubit.getInfo,
              message: state.message,
            );
          } else if (state is GetInfoSuccessState) {
            return FadeInLeft(
              duration: const Duration(milliseconds: 200),
              animate: true,
              curve: Curves.linear,
              child: CustomButton(
                label: translate('share_app', context),
                onPressed: () {
                  if (Platform.isIOS) {
                    Share.share(cubit.infoResponse.application.appStore);
                  } else {
                    Share.share(
                      cubit.infoResponse.application.googlePlay,
                    );
                  }
                },
                buttonStyle: titilliumBold.copyWith(color: Colors.white),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
