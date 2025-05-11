import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoScreen extends StatelessWidget {
  const ContactInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'معلومات التواصل',
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const Column(
            children: [
              ContactItem(
                icon: FontAwesomeIcons.whatsapp,
                label: 'واتساب',
                url: 'https://wa.me/966500000000',
                color: Colors.green,
              ),
              ContactItem(
                icon: FontAwesomeIcons.phone,
                label: 'اتصال',
                url: 'tel:+966500000000',
                color: Colors.blueGrey,
              ),
              ContactItem(
                icon: FontAwesomeIcons.youtube,
                label: 'يوتيوب',
                url: 'https://youtube.com/@yourchannel',
                color: Colors.red,
              ),
              ContactItem(
                icon: FontAwesomeIcons.facebook,
                label: 'فيسبوك',
                url: 'https://facebook.com/jalalkoba',
                color: Color(0xFF1877F2),
              ),
              ContactItem(
                icon: FontAwesomeIcons.instagram,
                label: 'إنستغرام',
                url: 'https://instagram.com/yourprofile',
                color: Color(0xFFC13584),
              ),
              ContactItem(
                icon: FontAwesomeIcons.telegram,
                label: 'تيليغرام',
                url: 'https://t.me/yourchannel',
                color: AppColors.LIGHT_BLUE,
              ),
              ContactItem(
                icon: FontAwesomeIcons.xTwitter,
                label: 'تويتر',
                url: 'https://x.com/yourhandle',
                color: Color(0xFF1DA1F2),
              ),
              ContactItem(
                icon: FontAwesomeIcons.solidEnvelope,
                label: 'الإيميل',
                url: 'mailto:youremail@example.com',
                color: Colors.deepOrange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color color;

  const ContactItem({
    super.key,
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
  });

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
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
