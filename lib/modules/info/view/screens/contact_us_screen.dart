import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/modules/info/cubit/info_cubit.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/try_again.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({super.key, required this.infoCubit});

  final InfoCubit infoCubit;

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.infoCubit.state is InfoInitial) {
      widget.infoCubit.getInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'معلومات التواصل',
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    ContactItem(
                      icon: FontAwesomeIcons.whatsapp,
                      label: 'واتساب',
                      link: infoCubit.infoResponse.contact.whatsapp,
                      color: Colors.green,
                    ),
                    ContactItem(
                      icon: FontAwesomeIcons.phone,
                      label: 'اتصال',
                      link: infoCubit.infoResponse.contact.phone,
                      color: Colors.blueGrey,
                    ),
                    ContactItem(
                      icon: FontAwesomeIcons.youtube,
                      label: 'يوتيوب',
                      link: infoCubit.infoResponse.contact.youtube,
                      color: Colors.red,
                    ),
                    ContactItem(
                      icon: FontAwesomeIcons.facebook,
                      label: 'فيسبوك',
                      link: infoCubit.infoResponse.contact.facebook,
                      color: const Color(0xFF1877F2),
                    ),
                    ContactItem(
                      icon: FontAwesomeIcons.instagram,
                      label: 'إنستغرام',
                      link: infoCubit.infoResponse.contact.instagram,
                      color: const Color(0xFFC13584),
                    ),
                    ContactItem(
                      icon: FontAwesomeIcons.telegram,
                      label: 'تيليغرام',
                      link: infoCubit.infoResponse.contact.telegram,
                      color: AppColors.LIGHT_BLUE,
                    ),
                    ContactItem(
                      icon: FontAwesomeIcons.xTwitter,
                      label: 'تويتر',
                      link: infoCubit.infoResponse.contact.twitter,
                      color: const Color(0xFF1DA1F2),
                    ),
                    ContactItem(
                      icon: FontAwesomeIcons.solidEnvelope,
                      label: 'الإيميل',
                      link: infoCubit.infoResponse.contact.email,
                      color: Colors.deepOrange,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String link;
  final Color color;

  const ContactItem({
    super.key,
    required this.icon,
    required this.label,
    required this.link,
    required this.color,
  });

  Future<void> _launchUrl() async {
    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(link)) {
      EasyLauncher.email(email: link);
    } else if (RegExp(r'^[0-9]{10,15}$').hasMatch(link)) {
      EasyLauncher.call(number: link);
    } else {
      EasyLauncher.url(url: link);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      delay: Duration(milliseconds: 100 * Random().nextInt(6)),
      child: Card(
        color: AppColors.WHITE,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: ListTile(
          leading: FaIcon(icon, color: color, size: 26.sp),
          title: Text(label, style: titilliumBold),
          trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.sp),
          onTap: _launchUrl,
        ),
      ),
    );
  }
}
