import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class PickImageDialog extends StatelessWidget {
  const PickImageDialog({
    super.key,
    required this.onSelect,
  });
  final void Function({required ImageSource imageSource}) onSelect;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.photo_library,
              color: AppColors.PRIMARY,
            ),
            title: Text(
              'اختر من المعرض',
              style: titilliumBold,
            ),
            onTap: () async {
              onSelect(imageSource: ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.photo_camera,
              color: AppColors.PRIMARY,
            ),
            title: Text('التقط صورة', style: titilliumBold),
            onTap: () async {
              onSelect(imageSource: ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }
}
