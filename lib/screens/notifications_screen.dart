import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/modules/notifications/cubit/notifications_cubit.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/notifications/models/notification.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/no_data.dart';
import 'package:my_project_new/widgets/notification_card.dart';
import 'package:my_project_new/widgets/try_again.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    context.read<NotificationsCubit>()
      ..refreshController.loadComplete()
      ..page = 1
      ..getNotifications(markRead: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: translate("notifications", context),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            final NotificationsCubit cubit = context.read<NotificationsCubit>();

            // return ListView.separated(
            //   separatorBuilder: (context, index) => SizedBox(height: 10.h),
            //   padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 20.h),
            //   physics: const BouncingScrollPhysics(),
            //   itemCount: 10,
            //   itemBuilder: (context, index) => NotificationCard(
            //       notification: AppNotification(
            //           title: "لقد تم الاشتراك بكورس الرياضيات بنجاح",
            //           body: "",
            //           state: 0,
            //           data: [],
            //           clickable: true,
            //           createdAt: DateTime.now())),
            // );
            if (state is GetNotificationsLoadingState) {
              return const AppLoading();
            }
            if (state is GetNotificationsErrorState) {
              return TryAgain(
                  onTap: () {
                    cubit.getNotifications();
                  },
                  message: state.message);
            }

            if (cubit.notifications.isEmpty) {
              return const Nodata();
            }
            return SmartRefresher(
              controller: cubit.refreshController,
              onLoading: () {
                cubit.getNotifications();
              },
              onRefresh: () async {
                cubit.page = 1;

                await cubit.getNotifications();
                cubit.refreshController.loadComplete();
              },
              enablePullUp: true,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.notifications.length,
                itemBuilder: (context, index) =>
                    NotificationCard(notification: cubit.notifications[index]),
              ),
            );
          },
        ));
  }
}




 