import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/library/view/widgets/library_section_card.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate('library', context),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            child: Image.asset(Images.libraryTop, width: 1.sw),
          )),
          SliverGrid.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: .9, mainAxisSpacing: 20.h),
            itemBuilder: (context, index) {
              return LibrarySectionCard(
                  imagePath: Images.course3,
                  label: "الثالث الثانوي",
                  footerColor: AppColors.appColors[index % 4]);
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20.h),
          )
        ],
      ),
    );
  }
}
