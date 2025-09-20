import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';

class ServerMessageSheet extends StatefulWidget {
  const ServerMessageSheet({super.key});

  static void showServerMessageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return const ServerMessageSheet();
      },
    );
  }

  @override
  State<ServerMessageSheet> createState() => _ServerMessageSheetState();
}

class _ServerMessageSheetState extends State<ServerMessageSheet> {
  bool isMainSelected = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4.h,
            width: 40.w,
            decoration: BoxDecoration(
                color: AppColors.DARK_GREY,
                borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(height: 12),
          ToggleButtons(
            isSelected: [isMainSelected, !isMainSelected],
            onPressed: (index) {
              setState(() {
                isMainSelected = index == 0;
              });
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(12),
            selectedColor: Colors.white,
            fillColor: AppColors.PRIMARY,
            textStyle: titilliumBold,
            color: Colors.black,
            constraints: const BoxConstraints(minHeight: 40, minWidth: 140),
            children: const [
              Text('السيرفر الرئيسي'),
              Text('السيرفر الاحتياطي'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'إذا لم يعمل السيرفر الأساسي، قم بتشغيل السيرفر الاحتياطي',
            textAlign: TextAlign.center,
            style: titilliumSemiBold,
          ),
          const Divider(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تلقائي (360P)',
                style: TextStyle(color: Colors.black54),
              ),
              Text('الدقة', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
