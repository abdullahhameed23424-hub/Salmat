// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:salamat/apis/urls.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/modules/video/cubit/video_cubit.dart';
import 'package:salamat/modules/video/cubit/video_state.dart';
import 'package:salamat/modules/video/models/my_viedeo.dart';
import 'package:salamat/modules/video/video_widget.dart';
import 'package:salamat/widgets/try_again.dart';

class ExplanationVideo extends StatefulWidget {
  const ExplanationVideo({
    super.key,
    required this.url,
  });
  final String url;
  @override
  State<ExplanationVideo> createState() => _ExplanationVideoState();
}

class _ExplanationVideoState extends State<ExplanationVideo> {
  VideoCubit videoCubit = VideoCubit();

  @override
  void dispose() {
    videoCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: " widget.courseScreen.tag", // to do
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BlocProvider(
              lazy: false,
              create: (context) => videoCubit
                ..setStreams([
                  MyVideo(
                      link: "${Urls.storageUrl}${widget.url}",
                      value: 0,
                      quality: "")
                ])
                ..initFromNetwork2(0, Duration.zero),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: BlocBuilder<VideoCubit, VideoState>(
                  builder: (context, state) {
                    if (state is VideoLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.PRIMARY,
                        ),
                      );
                    }
                    if (state is VideoErrorState) {
                      return TryAgain(
                        message: state.error,
                        onTap: () {
                          videoCubit
                            ..setStreams([
                              MyVideo(
                                  link:
                                      "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4", //  "${Urls.storageUrl}${widget.oneCourseCubit.introVideo!}",
                                  value: 0,
                                  quality: "")
                            ])
                            ..initFromNetwork2(0, Duration.zero);
                        },
                      );
                    }

                    return VideoWidget2(
                      videoCubit: context.read<VideoCubit>(),
                    );
                  },
                ),
              ),
            )));
  }
}
