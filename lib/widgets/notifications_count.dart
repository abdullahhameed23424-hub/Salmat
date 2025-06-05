import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:my_project_new/constant/custom_themes.dart';
class NotificationsCount extends StatelessWidget {
  const NotificationsCount({
    super.key, required this.num,
  });
  final int num;
  @override
  Widget build(BuildContext context) {
     

    if (num == 0) {
      return const SizedBox();
    }
    return Positioned(
      top: 3,
      right: 5,
      child: Container(
        // co
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red.withOpacity(0.9)),
        child: Text(
          textAlign: TextAlign.center,
          num < 100 ? "$num" : "+99",
          style: titilliumBold.copyWith(fontSize: 6.sp, color: Colors.white),
        ),
      ),
    );
  }
}
