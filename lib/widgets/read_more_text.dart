import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLength;

  const ReadMoreText({
    super.key,
    required this.text,
    this.maxLength = 150,
  });

  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

class ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final text = widget.text;
    final maxLength = widget.maxLength;

    String firstHalf = '';
    String secondHalf = '';

    if (text.length > maxLength) {
      firstHalf = text.substring(0, maxLength);
      secondHalf = text.substring(maxLength, text.length);
    } else {
      firstHalf = text;
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: RichText(
        text: TextSpan(
          style: titilliumSemiBold.copyWith(
            color: AppColors.BLACK,
          ),
          children: <TextSpan>[
            TextSpan(text: firstHalf),
            if (isExpanded)
              TextSpan(
                text: secondHalf,
                style: titilliumSemiBold.copyWith(
                  color: AppColors.BLACK,
                ),
              ),
            if (!isExpanded && secondHalf.isNotEmpty)
              const TextSpan(
                text: '... ',
              ),
            if (!isExpanded && secondHalf.isNotEmpty)
              TextSpan(
                text: 'عرض المزيد',
                style: titilliumBold.copyWith(color: AppColors.LIGHT_BLUE),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      isExpanded = true;
                    });
                  },
              ),
            if (isExpanded)
              const TextSpan(
                text: ' ',
              ),
            if (isExpanded)
              TextSpan(
                text: 'عرض أقل',
                style: titilliumBold.copyWith(color: AppColors.LIGHT_BLUE),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      isExpanded = false;
                    });
                  },
              ),
          ],
        ),
      ),
    );
  }
}
