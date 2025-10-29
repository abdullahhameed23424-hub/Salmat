import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'package:salamat/modules/video/custom_controls.dart';
import 'package:salamat/modules/video/cubit/video_state.dart';
import 'package:salamat/modules/video/models/my_viedeo.dart';
import 'package:salamat/utils/debouncer.dart';
import 'package:video_player/video_player.dart';

class Restriction {
  Duration duration;
  int index;
  bool pass = false;
  bool show = true;
  Restriction(this.duration, this.index, this.pass, this.show);
}

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(InitialState());

  VideoPlayerController? controller;
  AudioPlayer audioPlayer = AudioPlayer();
  ChewieController? chewieController;
  bool loading = true;
  int selectedQuality = 1;
  double playbackSpeed = 1;
  List<String> audioStreams = [];
  // late Future<void> ?initStream;
  Future<void>? initStream;
  late List<MyVideo> streamsList = [];
  VideoViewType viewType = AppSharedPreferences.viewType == VideoViewType.textureView.name
     ?VideoViewType.textureView:VideoViewType.platformView;
  late String path;

  bool init = false;

  final List<Restriction> _seekRestrictions = [];
  List<Restriction> get seekRestrictions => _seekRestrictions;

  void setStreams(List<MyVideo> streamsList) {
    this.streamsList = streamsList;
  }

  void setAudioStreams(List<String> audioStreams) {
    this.audioStreams = audioStreams;
  }

  Future<void> initFromNetwork2(dynamic selected, Duration duration) async {

     emit(VideoLoadingState());
    selectedQuality = 0;
    if (selected != -1 && selected < streamsList.length) {
      selectedQuality = selected;
    }

    controller = VideoPlayerController.networkUrl(
      Uri.parse(streamsList[selectedQuality].link),
      viewType: viewType,
    );

    initStream = controller!.initialize();
    try {
      await initStream;
    }catch(error){
      emit(VideoErrorState(error.toString()));
      return;
    }
    await controller!.seekTo(duration);

    chewieController = ChewieController(
      videoPlayerController: controller!,
      aspectRatio: controller!.value.aspectRatio,
      customControls: CustomControls(
        videoCubit: this,
      ),
      autoPlay: false,
    );
    emit(VideoSuccessfulState());


    return await initStream;
  }


  void changePlatformView(VideoViewType type)async{
    AppSharedPreferences.saveViewType(type.name);

    await controller?.pause();
    await audioPlayer.pause();
    Duration cur = controller!.value.position;
    viewType = type;
    await dispose(keepAudio: true);
    await initFromNetwork2(selectedQuality, cur);
    controller!.addListener(listener);
    emit(VideoSuccessfulState());
  }

  void changePlatformViewOffline(VideoViewType type)async{
    AppSharedPreferences.saveViewType(type.name);

    await controller?.pause();
    await audioPlayer.pause();
    viewType = type;
    await dispose(keepAudio: true);
    await initFromFile(path);
    controller!.addListener(listener);
    emit(VideoSuccessfulState());
  }

  void changeQuality(int quality) async {
    emit(VideoLoadingState());
    await controller?.pause();
    await audioPlayer.pause();
    Duration cur = controller!.value.position;
    await dispose(keepAudio: true);
    await initFromNetwork2(quality, cur);
    selectedQuality = quality;
    controller!.addListener(listener);
    emit(VideoSuccessfulState());
  }

  void initVideoWithAudio() async {
    emit(VideoLoadingState());
    if (AppSharedPreferences.getQuality != -1) {
      selectedQuality = AppSharedPreferences.getQuality;
    } else {
      selectedQuality = streamsList.length ~/ 2;
    }
    try {
      await Future.wait([
        audioPlayer.setUrl(audioStreams[0]),
        initFromNetwork2(selectedQuality, const Duration(milliseconds: 0))
      ]);
    } catch (error) {
      emit(VideoErrorState(error.toString()));
      return;
    }
    emit(VideoSuccessfulState());
    controller!.addListener(listener);
    audioPlayer.playerStateStream.listen(playerStateStream);
  }

  Future<void> initFromFile(String path) async {
    this.path = path;
    emit(VideoLoadingState());
    controller = VideoPlayerController.file(File(path),
      viewType: viewType,
        );
    initStream = controller!.initialize();
    await initStream;
    chewieController = ChewieController(
      videoPlayerController: controller!,
      aspectRatio: controller!.value.aspectRatio,
      customControls: CustomControls(
        videoCubit: this,
      ),
      autoPlay: false,
    );
    emit(VideoSuccessfulState());
    return await initStream;
  }

  bool wasPlaying = false;
  bool isSeeking = false;

  Debouncer debouncer = Debouncer(milliseconds: 500);
  void listener() {
    // print(
    //     'show the two ${controller!.value.position.inMilliseconds - audioPlayer.position.inMilliseconds}');

    // if ((controller!.value.position.inMilliseconds -
    //             audioPlayer.position.inMilliseconds)
    //         .abs() >
    //     200) {
    //   double speed = controller!.value.position.inMilliseconds -
    //               audioPlayer.position.inMilliseconds <
    //           0
    //       ? 2 * (playbackSpeed)
    //       : 0.5 * (playbackSpeed);
    //   controller!.setPlaybackSpeed(speed);
    // } else {
    //   controller!.setPlaybackSpeed(playbackSpeed);
    // }
    //
    // wasPlaying = controller!.value.isPlaying == true &&
    //     controller!.value.isBuffering == true;
    // if (controller!.value.isPlaying == false ||
    //     controller!.value.isBuffering == true) {
    //   if (audioPlayer.playing) {
    //     audioPlayer.pause();
    //   }
    // } else if (controller!.value.isPlaying == true &&
    //     controller!.value.isBuffering == false) {
    //   if (audioPlayer.playing == false) {
    //     audioPlayer.play();
    //   }
    // }

    print("show the full screen ${chewieController?.isFullScreen}");

    // debouncer.run(() {
    //   for (int i = 0; i < _seekRestrictions.length; i++) {
    //     if (controller!.value.position.inMilliseconds >
    //             _seekRestrictions[i].duration.inMilliseconds &&
    //         isSeeking == false &&
    //         _seekRestrictions[i].show) {
    //       isSeeking = true;
    //       seekTo(_seekRestrictions[i].duration, i);
    //     }
    //   }
    // });
  }

  int time = 0;

  void playerStateStream(PlayerState state) async {
    if (state.playing == false) {
      if (controller!.value.isPlaying == true && wasPlaying == false) {
        await controller!.pause();
        // await controller!.seekTo(Duration(milliseconds:controller!.value.position.inMilliseconds));
      }
    } else if (state.playing == true) {
      if (controller!.value.isPlaying == false) {
        controller!.play();
      }
    }
  }

  void seekTo(Duration duration, int i) async {
    print("show the restriction ${_seekRestrictions[i].pass}");
    if (_seekRestrictions[i].pass == false) {
      await Future.wait([
        controller!.pause(),
        audioPlayer.pause(),
        controller!.seekTo(duration),
        audioPlayer.seek(duration)
      ]);
    } else {
      _seekRestrictions[i].show = false;
      await controller!.pause();
    }

    isSeeking = false;
    emit(VideoInterruptedState(_seekRestrictions[i]));
    // if(interrupt!= null) {
    //   interrupt!(_seekRestrictions[0]);
    // }
  }

  Future<void> dispose({bool keepAudio = false}) async {
    await initStream;

    controller?.dispose();
    if (keepAudio == false) {
      audioPlayer.dispose();
    }
    chewieController?.dispose();
  }

  void initVideo() {
    init = true;
    initFromNetwork2(0, Duration.zero);
    emit(VideoSuccessfulState());
  }

  void pause() {
    controller!.pause();
    audioPlayer.pause();
  }
}
