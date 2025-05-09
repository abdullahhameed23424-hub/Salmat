import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarBorderRadius: BorderRadius.zero,
      title: translate('privacy_policy', context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20.h,
          children: <Widget>[
            Image.asset(
              Images.privacyPolicyTop,
              width: 1.sw,
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
                    "نحن في سلامات نلتزم بحماية خصوصيتك وبياناتك الشخصية. تهدف سياسة الخصوصية هذه إلى إبلاغك بكيفية جمع واستخدام وحماية المعلومات التي تقدمها عند استخدام تطبيقنا. قد نقوم بجمع المعلومات التالية: • المعلومات الشخصية: مثل الاسم، البريد الإلكتروني، تاريخ الميلاد، ومعلومات الاتصال. • معلومات الاستخدام: مثل معلومات حول كيفية استخدامك للتطبيق، الصفحات التي تزورها، الوقت الذي تقضيه في التطبيق، والميزات التي تستخدمها. • المعلومات التقنية: مثل عنوان IP، نوع المتصفح، نظام التشغيل، وبيانات الجهاز. ▎2. كيفية استخدام المعلومات نستخدم المعلومات التي نجمعها للأغراض التالية: • لتحسين جودة الخدمة وتجربة المستخدم. • لتخصيص المحتوى والإعلانات. • للتواصل معك بشأن تحديثات التطبيق، العروض، والمحتوى التعليمي. • لتحليل البيانات وفهم كيفية استخدام التطبيق.",
                    style: titilliumRegular.copyWith(height: 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
