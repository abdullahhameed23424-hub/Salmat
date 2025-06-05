import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/widgets/custom_button.dart';

class TryAgain extends StatefulWidget {
  const TryAgain({
    super.key,
    required this.onTap,
    this.small = false,
    this.withImage = true,
    required this.message,
  });
  final Function() onTap;
  final String message;
  final bool small;
  final bool withImage;

  @override
  State<TryAgain> createState() => _TryAgainState();
}

class _TryAgainState extends State<TryAgain>
    with SingleTickerProviderStateMixin {
  late StreamController<bool> _networkStreamController;
  late Timer _timer;
  bool _isConnected = true;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
// animation
    _controller = AnimationController(
      upperBound: 0.05,
      lowerBound: -0.05,
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller.repeat(reverse: true);
// network listener

    _networkStreamController = StreamController<bool>.broadcast();
    _startMonitoring();
    _networkStreamController.stream.listen((isConnected) {
      if (isConnected && !_isConnected) {
        widget.onTap();
        print("Network reconnected");
      } else if (!isConnected && _isConnected) {
        print("Network disconnected");
      }
      if (mounted) {
        setState(() {
          _isConnected = isConnected;
        });
      }
    });
  }

  void _startMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      bool isConnected = await _checkConnection();
      _networkStreamController.add(isConnected);
    });
  }

  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    _networkStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.withImage)
            RotationTransition(
              turns: _controller,
              child: Image.asset(
                Images.errorImage,
                width: widget.small ? 125.w : 215.w,
              ),
            ),
          SizedBox(height: widget.small ? 8.h : 35.h),
          Text(widget.message,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: titilliumBold.copyWith(
                  color: const Color.fromARGB(255, 0, 55, 106),
                  fontSize: widget.small ? 11.sp : null)),
          SizedBox(height: widget.small ? 14.h : 35.h),
          CustomButton(
            size: widget.small ? Size(150.w, 40.h) : null,
            onPressed: widget.onTap,
            label: translate("try_again", context),
          )
        ],
      ),
    );
  }
}
