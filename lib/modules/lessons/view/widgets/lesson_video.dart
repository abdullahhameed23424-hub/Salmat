import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/helper/app_sharedPreferance.dart';
import 'package:my_project_new/modules/lessons/models/lesson.dart';
import 'package:my_project_new/modules/video/cubit/video_cubit.dart';
import 'package:my_project_new/modules/video/cubit/video_state.dart';
import 'package:my_project_new/modules/video/models/my_viedeo.dart';
import 'package:my_project_new/modules/video/video_widget.dart';
import 'package:my_project_new/widgets/try_again.dart';

class LessonVideo extends StatefulWidget {
  const LessonVideo({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  State<LessonVideo> createState() => _LessonVideoState();
}

class _LessonVideoState extends State<LessonVideo> {
  VideoCubit videoCubit = VideoCubit();

  @override
  void dispose() {
    videoCubit.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState

   print("hello ${AppSharedPreferences.getQuality}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: BlocProvider(
          lazy: false,
          create: (context) => videoCubit
            ..setStreams(
              widget.lesson.myVideos
              // MyVideo(
              //     link: "${Urls.storageUrl}${widget.lesson.myVideos}",
              //     value: 0,
              //     quality: "")
            )
            ..initFromNetwork2(AppSharedPreferences.getQuality, Duration.zero) ,
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
                      // videoCubit
                      //   ..setStreams([
                      //     MyVideo(
                      //         link:
                      //             "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4", //  "${Urls.storageUrl}${widget.oneCourseCubit.introVideo!}",
                      //         value: 0,
                      //         quality: "")
                      //   ])
                      //   ..initFromNetwork2(0, Duration.zero);
                    },
                  );
                }

                return VideoWidget2(
                  videoCubit: context.read<VideoCubit>(),
                );
              },
            ),
          ),
        ));
  }
}
