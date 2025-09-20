import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/info/cubit/info_cubit.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/try_again.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWithAdminDialog extends StatelessWidget {
  const ContactWithAdminDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfoCubit()..getInfo(),
      child: BlocBuilder<InfoCubit, InfoState>(
        builder: (context, state) {
          final InfoCubit cubit = context.read<InfoCubit>();
          if (state is GetInfoLoadingState) {
            return const AppLoading();
          }

          if (state is GetInfoErrorState) {
            return TryAgain(
                onTap: () {
                  cubit.getInfo();
                },
                message: state.message);
          }
          return SizedBox(
            height: 600.h,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Text(
                    translate('purchase_contact_department', context),
                    style: titilliumRegular,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      launchUrl(
                          Uri.parse(
                              "https://wa.me/${cubit.infoResponse.contact.phone}"),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Text(
                      translate("tap_to_contact", context),
                      style: titilliumBold.copyWith(
                          decoration: TextDecoration.underline),
                    )),
                const Spacer(),
                Image.asset(
                  Images.contact,
                  width: 1.sw,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
