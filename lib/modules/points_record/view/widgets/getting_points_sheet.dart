import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/dimensions.dart';

class GettingPointsSheet extends StatelessWidget {
  const GettingPointsSheet({
    super.key,
  });

  static void show(context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => const GettingPointsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: SizedBox(
          height: 0.6.sh,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16.w),
                color: AppColors.GRAY600,
                width: 50.w,
                height: 2,
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: Text(
                      'نظام النقاط من أحد الميزات التي تقدمها منصة سلامات التعليمية لطلابها وتشجيعاً لهم على المثابرة وخلق جو من التحدي والإصرار \n يمكن تحصيل النقاط من خلال حل الاختبارات ضمن وقتها المحدد وعلى كل سؤال يتم حله بشكل صحيح من أسئلة الاختبارات المؤتمتة يحصل الطالب على نقطة إضافية ..\nأيضا على كل اختبار تقليدي يتم حله يحصل الطالب على 100 نقطة على حسب حله وتقدير الأستاذ المصحح للنقاط المستحقة\nفي نهاية الدورة تجمع كل نقاط الطالب التي جمعها حيث يمكن للطالب استخدام تلك النقاط التي قام بتجميعها بشراء كورسات في المنصة والحصول على حسومات إضافية.'),
                ),
              )
            ],
          )),
    );
  }
}
