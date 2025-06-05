// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardtype;
  final bool isvisible;
  final bool readOnly;
  final double radius;
  final void Function()? functionsuffix;
  final Widget? iconsuffix;
  final Widget? prefixIcon;
  final int maxlines;
  final void Function(String)? onFieldSubmitted;
  final bool isPassword;
  final String? validatorMessage;
  final Color? color;
  final Color? labelColor;
  final TextInputAction? textInputAction;
  final bool edit;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? ontap;
  final void Function()? onEditingComplete;
  final String? hinttext;
  final String label;
  final FocusNode? focusNode;
  final bool enabled;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.keyboardtype,
    this.isvisible = false,
    this.readOnly = false,
    this.radius = 10.0,
    this.functionsuffix,
    this.iconsuffix,
    this.prefixIcon,
    this.maxlines = 1,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.validatorMessage,
    this.color,
    this.labelColor,
    this.textInputAction = TextInputAction.done,
    this.edit = false,
    this.onChanged,
    this.validator,
    this.ontap,
    this.onEditingComplete,
    this.hinttext,
    required this.label,
    this.focusNode,
    this.enabled = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              // primarySwatch: ColorResources.blueMaterialColor
              )),
      child: TextFormField(
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          // textInputAction: widget.nextFocusNode != null
          //     ? TextInputAction.next
          //     : widget.textInputAction,
          controller: widget.controller,
          cursorColor: AppColors.PRIMARY,
          cursorHeight: 20,
          keyboardType: widget.keyboardtype,
          obscureText: widget.isPassword ? showPassword : false,
          maxLines: widget.maxlines,
          onTap: widget.ontap,
          style: titilliumRegular.copyWith(fontSize: 18.sp),
          readOnly: widget.readOnly,
          decoration: InputDecoration(
            fillColor: widget.color,
            filled: true,
            alignLabelWithHint: true,
            labelText: widget.label,
            floatingLabelStyle: titilliumRegular.copyWith(
                color: widget.labelColor ?? AppColors.PRIMARY, fontSize: 14.sp),
            labelStyle: titilliumRegular.copyWith(fontSize: 16.sp),
            prefixIcon: widget.prefixIcon,
            enabled: true,
            hintText: widget.hinttext,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      showPassword = !showPassword;
                      setState(() {});
                    },
                    icon: showPassword
                        ? const Icon(
                            Icons.remove_red_eye_rounded,
                            color: AppColors.PRIMARY,
                          )
                        : const Icon(
                            Icons.visibility_off_sharp,
                            color: AppColors.PRIMARY,
                          ),
                  )
                : widget.iconsuffix,
            hintStyle: titleRegular,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.PRIMARY, width: 2),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.BLACK, width: 1),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.BLACK, width: 1),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            errorStyle: titilliumRegular.copyWith(fontSize: 12.sp),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
          validator: widget.validator),
    );
  }
}
