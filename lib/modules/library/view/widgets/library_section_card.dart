import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/library/models/library_section.dart';
import 'package:my_project_new/modules/library/view/screens/books_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/widgets/cached_image.dart';

class LibrarySectionCard extends StatelessWidget {
  final LibrarySection librarySection;
  final Color footerColor;
  const LibrarySectionCard({
    super.key,
    required this.librarySection,
    required this.footerColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pushTo(
          context: context,
          toPage: BooksScreen(librarySection: librarySection)),
      child: ZoomIn(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: boxShadow,
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: SizedBox(
                  width: 1.sw,
                  child: CachedImage(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    image: librarySection.image??'',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: footerColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      librarySection.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: titilliumBold.copyWith(color: AppColors.WHITE),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
