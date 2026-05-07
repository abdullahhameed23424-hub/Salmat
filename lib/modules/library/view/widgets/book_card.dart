import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/modules/downloads/download/bloc_v2/download_cubit.dart';
import 'package:salamat/modules/downloads/download/bloc_v2/download_state.dart';
import 'package:salamat/modules/downloads/file_manager/file_manager_cubit.dart';
import 'package:salamat/modules/library/models/library_book.dart';
import 'package:salamat/modules/library/view/widgets/circle_button.dart';
import 'package:salamat/widgets/cached_image.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.primaryColor, required this.book});
  final Color primaryColor;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadCubit2(
        link: book.file,
        fileName: 'book_${book.id}.pdf',
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

          return InkWell(
            onTap: () {
              if (isDownloaded) {
                _openFile(cubit);
              }
              //  else {
              //   EasyLauncher.url(url: book.file, mode: Mode.externalApp);
              // }
            },
            child: LayoutBuilder(builder: (context, constrains) {
              return ZoomIn(
                delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
                child: Container(
                  height: constrains.maxHeight,
                  width: constrains.maxWidth,
                  padding: EdgeInsets.all(0.w),
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: boxShadow,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 4.h),
                            width: constrains.maxWidth,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              book.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: titilliumBold.copyWith(
                                  color: AppColors.WHITE, fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CachedImage(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12)),
                                image: book.image,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (isDownloading)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  LinearProgressIndicator(
                                    value: cubit.progress / 100,
                                    color: primaryColor,
                                    backgroundColor:
                                        primaryColor.withOpacity(0.2),
                                  ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (cubit.mbProgress != null)
                                        Text(
                                          cubit.mbProgress!,
                                          style: titilliumRegular.copyWith(
                                            fontSize: 10.sp,
                                            color: AppColors.GRAY500,
                                          ),
                                        )
                                      else if (cubit.mbContentLength != null)
                                        Text(
                                          '0 / ${cubit.mbContentLength}MB',
                                          style: titilliumRegular.copyWith(
                                            fontSize: 10.sp,
                                            color: AppColors.GRAY500,
                                          ),
                                        ),
                                      Text(
                                        '${cubit.progress.toInt()}%',
                                        style: titilliumRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColors.GRAY500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              BookButton(
                                  text: 'فتح',
                                  primaryColor: primaryColor,
                                  isEnabled: isDownloaded,
                                  onTap: () {
                                    _openFile(cubit);
                                  }),
                              BookButton(
                                  text: isDownloading
                                      ? '${cubit.progress.toInt()}%'
                                      : 'تحميل',
                                  primaryColor: primaryColor,
                                  isEnabled: !isDownloaded && !isDownloading,
                                  onTap: () {
                                    cubit.requestDownload();
                                  }),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
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
        // Fallback if task is null for some reason but file exists
        EasyLauncher.url(url: 'file://$path', mode: Mode.externalApp);
      }
    }
  }
}
