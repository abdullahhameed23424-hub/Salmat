import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/info/view/widgets/contact_row.dart';
import 'package:my_project_new/modules/info/view/widgets/platform_feature_card.dart';
import 'package:my_project_new/modules/info/view/widgets/platform_owner_card.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/swaping_point.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: translate("about_us", context),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[_ImagesSlider(), _Info()])));
  }
}

class _ImagesSlider extends StatefulWidget {
  @override
  State<_ImagesSlider> createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<_ImagesSlider> {
  int _currentindex = 0;
  final CarouselSliderController controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 190.h,
          width: 1.sw,
          child: CarouselSlider(
              carouselController: controller,
              options: CarouselOptions(
                viewportFraction: 1,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentindex = index;
                  });
                },
                autoPlay: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
              ),
              items: [
                Image.asset(Images.aboutUsFirst, width: 1.sw),
                ConnectSlide(
                  backgroundImage: Images.aboutUsLinks1,
                  child: ContactUsLinks1(),
                ),
                ConnectSlide(
                  backgroundImage: Images.aboutUsLinks2,
                  child: ContactUsLinks2(),
                ),
              ]),
        ),
        SizedBox(height: 3.h),
        SwappingPoint(
            length: 5, //widget.infoCubit.whoUsImage.length,
            pageController: controller,
            currentIndex: _currentindex),
      ],
    );
  }
}

class ConnectSlide extends StatelessWidget {
  const ConnectSlide({
    super.key,
    required this.child,
    required this.backgroundImage,
  });
  final Widget child;
  final String backgroundImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundImage), fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}

class _Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          Text(translate('about_us', context),
              style: titilliumBold.copyWith(color: AppColors.PRIMARY)),
          Divider(
            height: 25.h,
            endIndent: 190.w,
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'مرحباً بكم في تطبيق '),
                TextSpan(
                  text: 'سلامات',
                  style: titilliumRegular.copyWith(color: AppColors.PRIMARY),
                ),
                const TextSpan(
                    text:
                        ' بإدارة الأستاذ جعفر، وجهتكم الموثوقة نحو عالم المعرفة والتعلم! نحن هنا لنقدم لكم تجربة تعليمية فريدة تجمع بين الابتكار والتفاعل، حيث نؤمن أن التعليم هو مفتاح النجاح في الحياة..'),
              ],
            ),
            style: titilliumRegular,
          ),
          SizedBox(height: 30.h),
          Text(translate('app_features', context),
              style: titilliumBold.copyWith(color: AppColors.PRIMARY)),
          SizedBox(height: 20.h),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9,
                crossAxisCount: 2,
                mainAxisSpacing: 25.h),
            itemBuilder: (context, index) => PlatformFeatureCard(
              image: Images.numbers[index % 4],
              number: '1',
              text: 'محتوى تعليمي مقسم إلى وحدات صغيرة وسهلة الفهم',
            ),
          ),
          SizedBox(height: 20.h),
          Text(translate('platform_owner', context),
              style: titilliumBold.copyWith(color: AppColors.PRIMARY)),
          SizedBox(height: 20.h),
          const PlatformOwnerCard(),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class ContactUsLinks1 extends StatelessWidget {
  const ContactUsLinks1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تواصل معنا الآن',
            style: titleHeader.copyWith(
                color: Colors.teal,
                decoration: TextDecoration.underline,
                decorationColor: Colors.teal),
          ),
          SizedBox(height: 5.h),
          ContactRow(
              icon: SvgPicture.asset(Images.whatsapp, width: 24.sp),
              text: '098877441155'),
          ContactRow(
              icon: Icon(Icons.facebook, color: Colors.blue),
              text: 'Facebook.com'),
          ContactRow(
              icon: Icon(Icons.telegram, color: AppColors.PRIMARY),
              text: '@Salamat_20'),
        ],
      ),
    );
  }
}

class ContactUsLinks2 extends StatelessWidget {
  const ContactUsLinks2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تواصل معنا الآن',
            style: titleHeader.copyWith(
                color: Colors.teal,
                decoration: TextDecoration.underline,
                decorationColor: Colors.teal),
          ),
          SizedBox(height: 5.h),
          ContactRow(
              icon: SvgPicture.asset(Images.insta, width: 24.sp),
              text: 'instgram.com'),
          ContactRow(
              icon: SvgPicture.asset(
                Images.linkedin,
                width: 24.sp,
              ),
              text: 'linkedin.com'),
          ContactRow(
              icon: SvgPicture.asset(
                Images.youtube,
                width: 24.sp,
              ),
              text: 'youtube.com'),
        ],
      ),
    );
  }
}
