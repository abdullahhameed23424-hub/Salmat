import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/info/cubit/info_cubit.dart';
import 'package:my_project_new/modules/info/view/widgets/contact_row.dart';
import 'package:my_project_new/modules/info/view/widgets/platform_feature_card.dart';
import 'package:my_project_new/modules/info/view/widgets/platform_owner_card.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/swaping_point.dart';
import 'package:my_project_new/widgets/try_again.dart';

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
        title: translate("about_us", context),
        body: BlocProvider.value(
          value: widget.infoCubit,
          child: BlocBuilder<InfoCubit, InfoState>(builder: (context, state) {
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
                child: Column(children: <Widget>[
              _ImagesSlider(infoCubit: infoCubit),
              _Info(infoCubit: infoCubit)
            ]));
          }),
        ));
  }
}

class _ImagesSlider extends StatefulWidget {
  final InfoCubit infoCubit;

  const _ImagesSlider({required this.infoCubit});
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
                  child: ContactUsLinks1(infoCubit: widget.infoCubit),
                ),
                ConnectSlide(
                  backgroundImage: Images.aboutUsLinks2,
                  child: ContactUsLinks2(infoCubit: widget.infoCubit),
                ),
              ]),
        ),
        SizedBox(height: 3.h),
        SwappingPoints(
            length: 3, pageController: controller, currentIndex: _currentindex),
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
  final InfoCubit infoCubit;

  const _Info({required this.infoCubit});
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
          Text(infoCubit.infoResponse.aboutUs.description,
              style: titilliumRegular),
          SizedBox(height: 30.h),
          Text(translate('app_features', context),
              style: titilliumBold.copyWith(color: AppColors.PRIMARY)),
          SizedBox(height: 20.h),
          GridView.builder(
            itemCount: infoCubit.infoResponse.features.texts.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9,
                crossAxisCount: 2,
                mainAxisSpacing: 25.h),
            itemBuilder: (context, index) => PlatformFeatureCard(
              image: index < 4 ? Images.numbers[index] : null,
              number: (index + 1).toString(),
              text: infoCubit.infoResponse.features.texts[index],
            ),
          ),
          SizedBox(height: 20.h),
          Text(translate('platform_manager', context),
              style: titilliumBold.copyWith(color: AppColors.PRIMARY)),
          SizedBox(height: 20.h),
          PlatformManagerCard(
              platformManager: infoCubit.infoResponse.platformManager),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class ContactUsLinks1 extends StatelessWidget {
  const ContactUsLinks1({super.key, required this.infoCubit});

  final InfoCubit infoCubit;

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
              text: infoCubit.infoResponse.contact.whatsapp),
          ContactRow(
              icon: Icon(Icons.facebook, color: Colors.blue),
              text: infoCubit.infoResponse.contact.facebook),
          ContactRow(
              icon: Icon(Icons.telegram, color: AppColors.PRIMARY),
              text: infoCubit.infoResponse.contact.telegram),
        ],
      ),
    );
  }
}

class ContactUsLinks2 extends StatelessWidget {
  const ContactUsLinks2({super.key, required this.infoCubit});

  final InfoCubit infoCubit;

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
              text: infoCubit.infoResponse.contact.instagram),
          ContactRow(
              icon: SvgPicture.asset(
                Images.linkedin,
                width: 24.sp,
              ),
              text: infoCubit.infoResponse.contact.linkedin),
          ContactRow(
              icon: SvgPicture.asset(
                Images.youtube,
                width: 24.sp,
              ),
              text: infoCubit.infoResponse.contact.youtube),
        ],
      ),
    );
  }
}
