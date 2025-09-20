import 'dart:async';

import 'package:flutter/material.dart';

import 'package:app_links/app_links.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/core/sqlite.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'package:salamat/helper/cach_helper.dart';
import 'package:salamat/modules/downloads/file_manager/file_manager_cubit.dart';
import 'package:salamat/modules/notifications/cubit/notifications_cubit.dart';
import 'package:salamat/modules/Theme/cubit/theme_cubit.dart';
import 'package:salamat/modules/startup/splash_screen.dart';
import 'package:salamat/screens/notifications_screen.dart';
import 'package:salamat/utils/device_type.dart';
import 'package:salamat/localization/cubit/localization_cubit.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/localization/language_model.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  await Network.init();
  await FileManagerCubit.init();
  await SqliteHelper.init();
  await FlutterDownloader.initialize();


  // await NotificationsFunctions.init();
  // print("fcm: ${await FirebaseMessaging.instance.getToken()}");
  // AppSharedPreferences.removeToken;

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  print("token is: ${AppSharedPreferences.getToken}");
  print("userID is: ${AppSharedPreferences.getUserID}");
  print("has token is: ${AppSharedPreferences.hasToken}");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;

  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();

    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (context) => const NotificationsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => LocalizationCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationsCubit()..getNotifications(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: getDeviceSize(context),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            List<Locale> locals = [];
            for (LanguageModel language in languages) {
              locals.add(
                Locale(language.languageCode, language.languageName),
              );
            }
            return BlocBuilder<LocalizationCubit, LocalizationState>(
                builder: (context, state) {
              final LocalizationCubit localizationCubit =
                  context.read<LocalizationCubit>();

              return MaterialApp(
                navigatorKey: navigatorKey,

                home: const SplashScreen(),
                theme: ThemeData(
                    appBarTheme: const AppBarTheme(
                      backgroundColor: AppColors.SECONDRY,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: AppColors.SECONDRY,
                          statusBarIconBrightness: Brightness.light, // Android
                          statusBarBrightness: Brightness.dark,
                          systemNavigationBarColor: AppColors.SECONDRY,
                          systemNavigationBarIconBrightness: Brightness.light
                          
                          // iOS
                          ),
                    ),
                    scaffoldBackgroundColor: AppColors.LIGHTGRAY,
                    colorScheme: const ColorScheme.light(
                        primary: AppColors.LOGO_PRIMARY),
                    fontFamily: "NotoKufiArabic"),
                debugShowCheckedModeBanner: false,
                locale: const Locale('ar'), //localizationCubit.appLocale,
                localizationsDelegates: localizationsDelegates,
                supportedLocales: locals,
              );
            });
          }),
    );
  }
}
