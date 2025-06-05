  import 'package:flutter/material.dart';
import 'package:my_project_new/widgets/app_loading.dart';
  import 'package:pull_to_refresh/pull_to_refresh.dart';  

  class AppRefresherHeader extends StatelessWidget {
    const AppRefresherHeader({
      super.key,
    });

    @override
    Widget build(BuildContext context) {
      return const WaterDropHeader(
        refresh: AppLoading(),
        complete: AppLoading(),
        idleIcon: AppLoading(),
        waterDropColor: Colors.transparent,
      );
    }
  }
