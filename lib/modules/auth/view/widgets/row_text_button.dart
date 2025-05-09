import 'package:flutter/material.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class RowTextButton extends StatelessWidget {
  const RowTextButton({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onClick,
    required this.transform,
  });
  final String title;
  final String buttonText;
  final VoidCallback onClick;
  final Matrix4? transform;
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: transform ?? Matrix4.identity(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "$title ",
            style: titilliumRegular.copyWith(),
          ),
          TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {
              onClick();
            },
            child: Text(
              buttonText,
              style: titilliumRegular.copyWith(
                  color: AppColors.PRIMARY,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.PRIMARY),
            ),
          ),
        ],
      ),
    );
  }
}
