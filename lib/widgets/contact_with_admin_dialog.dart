import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/info/cubit/info_cubit.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/try_again.dart';

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
                    translate('contact_admin_to_buy', context),
                    style: titilliumRegular,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      EasyLauncher.url(
                          url:
                              "https://wa.me/${cubit.infoResponse.adminContact.phone}");
                    },
                    child: Text(
                      translate("tap_to_contact", context),
                      style: titilliumBold.copyWith(
                          decoration: TextDecoration.underline),
                    )),
                const Spacer(),
                Image.asset(
                  Images.contactWhatsapp,
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
