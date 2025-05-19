import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/test/cubit/test_cubit.dart';
import 'package:my_project_new/modules/test/view/widgets/test_info.dart';
import 'package:my_project_new/utils/sliver_delegate.dart';

class CountersSqures extends StatelessWidget {
  const CountersSqures({
    super.key,
    required this.testCubit,
  });

  final TestCubit testCubit;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverDelegate(
          minHeight: 95.h,
          maxHeight: 105.h,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
            color: AppColors.SECONDRY,
            child: Row(
              children: [
                Expanded(
                  child: TestInfo(
                    text: translate('points', context),
                    value: testCubit.test.degree.toString(),
                  ),
                ),
                Expanded(
                  child: TestInfo(
                    text: translate('attempt_count', context),
                    value: testCubit.test.attemptCount.toString(),
                  ),
                ),
                Expanded(
                  child: TestTimer(testCubit: testCubit),
                ),
              ],
            ),
          ),
        ));
  }
}

class TestTimer extends StatefulWidget {
  const TestTimer({
    super.key,
    required this.testCubit,
  });

  final TestCubit testCubit;

  @override
  State<TestTimer> createState() => _TestTimerState();
}

class _TestTimerState extends State<TestTimer> {
  late Timer _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.testCubit.test.minutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime() {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return TestInfo(
      text: translate('timer', context),
      value: _formatTime(),
    );
  }
}
