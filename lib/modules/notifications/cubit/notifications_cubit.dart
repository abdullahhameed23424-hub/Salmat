import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/notifications/models/notification.dart';
import 'package:my_project_new/modules/notifications/models/notifications_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitialState());
  static NotificationsCubit get(context) => BlocProvider.of(context);

  int page = 1;
  int unreadNotifications = 0;
  final RefreshController refreshController = RefreshController();
  List<AppNotification> notifications = [];

  void makeUnreadZero() {
    unreadNotifications = 0;
    emit(MakeUnreadZeroState());
  }

  Future<void> getNotifications({int markRead = 0}) async {
    if (page == 1) {
      emit(GetNotificationsLoadingState());
    }

    try {
      final Response response = await Network.getData(
          url: Urls.notifications(read: markRead, page: page));
      final NotificationsResponse notificationsResponse =
          NotificationsResponse.fromJson(response.data);

      if (page > 1) {
        notifications.addAll(notificationsResponse.data.notifications);
        if (notificationsResponse.data.notifications.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        notifications = notificationsResponse.data.notifications;
      }
      page = notificationsResponse.data.currentPage + 1;

      emit(GetNotificationsSuccessState());
    } on DioException catch (error) {
      emit(GetNotificationsErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetNotificationsErrorState(message: unknownError()));
    }
  }
}
