import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/dimensions.dart';
import 'package:my_project_new/modules/auth/cubit/auth_cubit.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class DeleteUserImageDialog extends StatelessWidget {
  const DeleteUserImageDialog({
    super.key,
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return FlipInY(
      duration: const Duration(milliseconds: 300),
      child: Dialog(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'هل تريد حذف صورة الملف الشخصي؟',
                style: titilliumBold,
              ),
              SizedBox(height: 1.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  // if (state is EditProfileErrorState) {
                  //   customSnackBar(
                  //       context: context, success: 0, message: state.message);
                  //   Navigator.pop(context);
                  // }
                  // if (state is EditProfileSuccessState) {
                  //   customSnackBar(
                  //       context: context,
                  //       success: 1,
                  //       message: "تم حذف الصورة بنجاح");
                  //   Navigator.pop(context);
                  // }
                },
                builder: (context, state) {
                  // if (state is EditProfileLoadingState) {
                  //   return const AppLoading();
                  // }

                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'نعم',
                            style: titilliumSemiBold.copyWith(
                                color: AppColors.RED),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('لا', style: titilliumSemiBold),
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
