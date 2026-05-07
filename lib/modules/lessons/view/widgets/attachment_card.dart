import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/modules/downloads/download/bloc_v2/download_cubit.dart';
import 'package:salamat/modules/downloads/download/bloc_v2/download_state.dart';
import 'package:salamat/modules/downloads/file_manager/file_manager_cubit.dart';
import 'package:salamat/modules/lessons/models/app_file.dart';
import 'package:salamat/modules/lessons/view/widgets/attachment_button.dart';
import 'package:salamat/modules/lessons/view/widgets/progress_bar_with_percentage.dart';

class AttachmentCard extends StatelessWidget {
  final AppFile file;
  const AttachmentCard({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final String extension = file.url.split('.').last.split('?').first;
    final String fileName = 'attachment_${file.id}.$extension';

    return BlocProvider(
      create: (context) => DownloadCubit2(
        link: file.url,
        fileName: fileName,
        localPath: FileManagerCubit.privatePath,
        showContentLength: true,
      )..init(),
      child: BlocBuilder<DownloadCubit2, DownloadState2>(
        builder: (context, state) {
          final cubit = context.read<DownloadCubit2>();
          final bool isDownloaded = state is CompleteState;
          final bool isDownloading = state is RunningState ||
              state is QueuedState ||
              state is RequestingState;

          return FadeInLeft(
            duration: const Duration(milliseconds: 400),
            delay: Duration(milliseconds: 100 * (1 + Random().nextInt(5))),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /// [ICON_WITH_FILENAME]
                  Row(
                    children: <Widget>[
                      /// [ICON]
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.LIGHTGRAY,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Icon(
                          Icons.attach_file,
                          size: 24.sp,
                          color: AppColors.PRIMARY,
                        ),
                      ),
                      SizedBox(width: 12.w),

                      /// [FILENAME]
                      Expanded(
                        child: Text(
                          file.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: titilliumBold.copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  /// [PROGRESS_BAR_WITH_PERCENTAGE]
                  if (isDownloading) ProgressBarWithPercentage(cubit: cubit),
                  const Spacer(),

                  /// [OPEN_DOWNLOAD_BUTTONS]
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      /// [OPEN]
                      Expanded(
                        child: AttachmentButton(
                          text: 'فتح',
                          color: isDownloaded ? AppColors.PRIMARY : Colors.grey,
                          isEnabled: isDownloaded,
                          onTap: () => _openFile(cubit),
                        ),
                      ),
                      SizedBox(width: 10.w),

                      /// [DOWNLOAD]
                      Expanded(
                        child: AttachmentButton(
                          text: isDownloading
                              ? '${cubit.progress.toInt()}%'
                              : 'تحميل',
                          color: !isDownloaded && !isDownloading
                              ? AppColors.PRIMARY
                              : Colors.grey,
                          isEnabled: !isDownloaded && !isDownloading,
                          onTap: () => cubit.requestDownload(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _openFile(DownloadCubit2 cubit) async {
    final path = cubit.localPath + cubit.fileName;
    if (await File(path).exists()) {
      if (cubit.task != null) {
        cubit.downloader.openFile(task: cubit.task!);
      } else {
        EasyLauncher.url(url: 'file://$path', mode: Mode.externalApp);
      }
    }
  }
}
