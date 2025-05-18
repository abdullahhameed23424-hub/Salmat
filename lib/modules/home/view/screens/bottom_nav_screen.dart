import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/modules/auth/cubit/auth_cubit.dart';
import 'package:my_project_new/utils/global_functions.dart';

import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/modules/home/view/screens/home_screen.dart';
import 'package:my_project_new/modules/home/view/screens/more_info_screen.dart';
import 'package:my_project_new/modules/home/view/widgets/bottom_nav_bar.dart';
import 'package:my_project_new/modules/sections/view/screens/sections_screen.dart';
import 'package:my_project_new/modules/auth/view/screens/profile_screen.dart';
import 'package:my_project_new/screens/notifications_screen.dart';
import 'package:my_project_new/widgets/app_shimmer.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/widgets/description_shimmer.dart';

final ValueNotifier selectedPage = ValueNotifier<int>(1);

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

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

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  final AuthCubit authCubit = AuthCubit();
  @override
  void initState() {
    print("init getProfile ");
    authCubit.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedPage,
        builder: (context, value, child) => Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldkey,
            appBar: PreferredSize(
              preferredSize: Size(1.sw, 90.h),
              child: _AppBar(scaffoldkey, authCubit),
            ),
            extendBody: true,
            body: taps[selectedPage.value]["screen"],
            bottomNavigationBar: BottomNavBar(
              onChange: (index) {
                selectedPage.value = index;
                setState(() {});
              },
            )));
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar(this.scaffoldkey, this.authCubit);
  final GlobalKey<ScaffoldState> scaffoldkey;
  final AuthCubit authCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: BlocBuilder<AuthCubit, AuthState>(
        bloc: authCubit,
        builder: (context, state) {
          final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

          return AppBar(
              actions: const [SizedBox.shrink()], // to hide drawer button
              surfaceTintColor: Colors.transparent,
              shadowColor: selectedPage.value != 2 ? Colors.black : null,
              backgroundColor: AppColors.SECONDRY,
              titleSpacing: 10,
              automaticallyImplyLeading: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: AppColors.SECONDRY),
              toolbarHeight: 90.h,
              title: Row(
                spacing: 10.w,
                children: <Widget>[
                  if (state is GetProfileSuccessState)
                    _UserHeader(authCubit: authCubit),
                  if (state is GetProfileLoadingState) _UserHeaderShimmer(),
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
                        count: 12,
                        child: const Icon(
                          Icons.notifications,
                          color: AppColors.WHITE,
                        ),
                      )),
                ],
              ));
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
        pushTo(
            context: context,
            toPage: ProfileScreen(
              authCubit: authCubit,
            ));
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
            child: DescriptionShimmer(
              linesNumber: 2,
            ))
      ],
    );
  }
}
