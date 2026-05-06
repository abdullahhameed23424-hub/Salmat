import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/info/cubit/info_cubit.dart';
import 'package:salamat/modules/info/view/widgets/images_slider.dart';
import 'package:salamat/modules/info/view/widgets/rest_of_info.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/app_scaffold.dart';
import 'package:salamat/widgets/try_again.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key, required this.infoCubit});

  final InfoCubit infoCubit;

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
      title: translate('about_us', context),
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
                onTap: infoCubit.getInfo,
                message: state.message,
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  /// [IMAGES_SLIDER]
                  ImagesSlider(infoCubit: infoCubit),

                  /// [REST_OF_INFO]
                  RestOfInfo(infoCubit: infoCubit),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
