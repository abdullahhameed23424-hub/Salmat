import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/auth/cubit/auth_cubit.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/widgets/pick_image_dialog.dart';

class EditImage extends StatelessWidget {
  const EditImage({
    super.key,
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Hero(
          tag: "profile-image",
          child: Container(
            clipBehavior: Clip.hardEdge,
            width: 125.w,
            height: 125.w,
            decoration: BoxDecoration(
              color: AppColors.WHITE,
              boxShadow: boxShadow,
              shape: BoxShape.circle,
            ),
            child: Builder(
              builder: (context) {
                if (authCubit.fileUserImage != null) {
                  return Image.file(
                    authCubit.fileUserImage!,
                    fit: BoxFit.cover,
                  );
                } else if (authCubit.user.image != '') {
                  return CachedImage(image: authCubit.user.image);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        ElasticIn(
          child: IconButton(
              style: IconButton.styleFrom(
                  backgroundColor: AppColors.PRIMARY.withOpacity(0.8)),
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (BuildContext context) {
                      return PickImageDialog(
                        onSelect: ({required ImageSource imageSource}) {
                          authCubit.pickImage(imageSource);
                          Navigator.of(context).pop();
                        },
                      );
                    });
              },
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
              )),
        ),
        // Positioned(
        //     right: 0,
        //     child: ElasticIn(
        //       child: IconButton(
        //           style: IconButton.styleFrom(
        //               backgroundColor: ColorResources.RED.withOpacity(0.8)),
        //           onPressed: () {
        //             showDialog(
        //                 context: context,
        //                 builder: (context) =>
        //                     DeleteUserImageDialog(authCubit: authCubit));
        //           },
        //           icon: const Icon(
        //             Icons.restore_from_trash,
        //             color: Colors.white,
        //           )),
        //     ))
      ],
    );
  }
}
