import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'package:salamat/modules/auth/cubit/auth_cubit.dart';
import 'package:salamat/modules/auth/view/screens/login_screen.dart';
import 'package:salamat/modules/startup/get_started_screen.dart';
import 'package:salamat/utils/global_functions.dart';

import 'package:salamat/constant/images.dart';
import 'package:salamat/modules/home/view/screens/home_screen.dart';
import 'package:salamat/modules/home/view/screens/more_info_screen.dart';
import 'package:salamat/modules/home/view/widgets/bottom_nav_bar.dart';
import 'package:salamat/modules/sections/view/screens/sections_screen.dart';
import 'package:salamat/modules/auth/view/screens/profile_screen.dart';
import 'package:salamat/screens/notifications_screen.dart';
import 'package:salamat/widgets/app_shimmer.dart';
import 'package:salamat/widgets/cached_image.dart';
import 'package:salamat/widgets/description_shimmer.dart';
import 'package:salamat/widgets/try_again.dart';

final ValueNotifier selectedPage = ValueNotifier<int>(1);

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});
  static final AuthCubit authCubit = AuthCubit();

  @override
  State<BottomNavScreen> createState() => BottomNavScreenState();
}

class BottomNavScreenState extends State<BottomNavScreen> {
  void changeScreen(int index) {
    selectedPage.value = index;
    setState(() {});
  }

  final List taps = [
    {
      "title": "sections",
      "image": Images.sectoins,
      "screen": const SectionsScreen()
    },
    {"title": "home", "image": Images.home, "screen": const HomeScreen()},
    {"title": "more", "image": Images.more, "screen": MoreInfoScreen()},
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    if (AppSharedPreferences.hasToken) {
      BottomNavScreen.authCubit.getProfile();
    }
    Future.delayed(
        const Duration(
          milliseconds:
              200, // to ensure that screen is been built then call after build it
        ), () {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: AppColors.SECONDRY,
          statusBarIconBrightness: Brightness.light, // Android
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.SECONDRY,
          systemNavigationBarIconBrightness: Brightness.light

          // iOS
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedPage,
        builder: (context, value, child) => SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  key: scaffoldKey,
                  appBar: PreferredSize(
                    preferredSize: Size(1.sw, 90.h),
                    child: _AppBar(scaffoldKey),
                  ),
                  extendBody: true,
                  body: taps[selectedPage.value]["screen"],
                  bottomNavigationBar: BottomNavBar(
                    onChange: (index) {
                      selectedPage.value = index;
                      setState(() {});
                    },
                  )),
            ));
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar(this.scaffoldKey);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BottomNavScreen.authCubit,
      child: BlocConsumer<AuthCubit, AuthState>(
        bloc: BottomNavScreen.authCubit,
        listener: (context, state) {
          if (state is UnAuthenticatedState) {
            AppSharedPreferences.removeToken;
            Network.init();
            pushAndRemoveUntilTo(context, toPage: GetStartedScreen());
          }
        },
        builder: (context, state) {
          final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
          if (state is GetProfileErrorState) {
            return TryAgain(
                withImage: false,
                small: true,
                onTap: () {
                  authCubit.getProfile();
                },
                message: state.message);
          }
          return AppBar(
              actions: const [SizedBox.shrink()], // to hide drawer button
              surfaceTintColor: Colors.transparent,
              shadowColor: selectedPage.value != 2 ? Colors.black : null,
              backgroundColor: AppColors.SECONDRY,
              titleSpacing: 10,
              automaticallyImplyLeading: false,
              toolbarHeight: 90.h,
              title: AppSharedPreferences.hasToken
                  ? Row(
                      spacing: 10.w,
                      children: <Widget>[
                        if (state is GetProfileSuccessState)
                          _UserHeader(authCubit: authCubit),
                        if (state is GetProfileLoadingState)
                          _UserHeaderShimmer(),
                        const Spacer(),
                        IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black12,
                              iconSize: 30.sp,
                            ),
                            onPressed: () {
                              pushTo(
                                  context: context,
                                  toPage: const NotificationsScreen());
                            },
                            icon: Badge.count(
                              backgroundColor: AppColors.RED.withAlpha(210),
                              isLabelVisible:
                                  authCubit.notificationCount > 0, //to do test
                              count: authCubit.notificationCount,
                              child: const Icon(
                                Icons.notifications,
                                color: AppColors.WHITE,
                              ),
                            )),
                      ],
                    )
                  : Text('أهلاً وسهلاً في تطبيق سلامات  👋🏻',
                      style: titleHeader.copyWith(color: Colors.white)));
        },
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader({
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(context: context, toPage: ProfileScreen());
      },
      child: Row(
        spacing: 10.w,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: CachedImage(
              boxFit: BoxFit.cover,
              image: authCubit.user.image,
              width: 60.w,
              height: 60.w,
            ),
          ),
          Column(
            spacing: 5.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("مرحباً 👋🏻",
                  style: titilliumBold.copyWith(color: AppColors.WHITE)),
              Text(authCubit.user.fullName, style: titilliumBold),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserHeaderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        AppShimmer(
          child: Container(
            width: 60.w,
            height: 60.h,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
          ),
        ),
        SizedBox(
            width: 150.w,
            child: const DescriptionShimmer(
              linesNumber: 2,
            ))
      ],
    );
  }
}
