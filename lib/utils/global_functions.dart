import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/dimensions.dart';

bool isNotValidEmail(String email) {
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  return !emailRegExp.hasMatch(email.trim());
}

bool isValidPhoneNumber(String phoneNumber) {
  final RegExp phoneRegex = RegExp(r'^09\d{8}$');
  return phoneRegex.hasMatch(phoneNumber);
}

void showBottomSheet(BuildContext context, Widget widget) {
  showModalBottomSheet(
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (context) => Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7, child: widget),
    ),
  );
}

void customSnackBar(BuildContext context,
    {required int success, required String message}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 2),
        backgroundColor: success == 0
            ? Colors.red
            : success == 1
                ? Colors.green
                : Colors.orange,
        content: ElasticIn(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: titilliumBold.copyWith(color: AppColors.WHITE),
          ),
        )),
  );
}

Future<dynamic> pushTo(
    {required BuildContext context, required Widget toPage}) async {
  return await Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => toPage));
}

Future<dynamic> pushNamedTo(
    {required BuildContext context,
    required String toPage,
    Object? arguments}) async {
  return await Navigator.of(context).pushNamed(toPage, arguments: arguments);
}

void pushAndRemoveUntilTo(BuildContext context, {required Widget toPage}) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => toPage),
    (route) => false,
  );
}

void pushReplacement({required BuildContext context, required Widget toPage}) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => toPage),
  );
}
