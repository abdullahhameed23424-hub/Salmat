import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/widgets/image_viewer.dart';
import 'package:my_project_new/utils/global_functions.dart';

class LessonImageCard extends StatelessWidget {
  const LessonImageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 400),
      delay: Duration(milliseconds: 100 * (1 + Random().nextInt(7))),
      child: InkWell(
        onTap: () => pushTo(
            context: context,
            toPage: const ImageViewer(
                imageUrl:
                    "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiwlqVwKry2d_Xb54RXjxEGBKP5okLfKCayZUWZ7FheoROo53kisEegIavCtvYySf6Ngxs6LXyZatZgJA-CAgFKF5fWB1pnOH-SlRViAo27JP4QzGVtIzdm-2quNrpviPESF8YEuYAH3Qk/s1600/%25D8%25A3%25D9%2588%25D8%25B1%25D8%25A7%25D9%2582+%25D8%25B9%25D9%2585%25D9%2584+%25D8%25AD%25D8%25AA%25D8%25A7%25D9%2585+%25D8%25AA%25D8%25BA%25D9%2581%25D9%2584_Page_3.jpg")),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: boxShadow,
                borderRadius: BorderRadiusDirectional.circular(20)),
            child: Hero(
              tag:
                  "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiwlqVwKry2d_Xb54RXjxEGBKP5okLfKCayZUWZ7FheoROo53kisEegIavCtvYySf6Ngxs6LXyZatZgJA-CAgFKF5fWB1pnOH-SlRViAo27JP4QzGVtIzdm-2quNrpviPESF8YEuYAH3Qk/s1600/%25D8%25A3%25D9%2588%25D8%25B1%25D8%25A7%25D9%2582+%25D8%25B9%25D9%2585%25D9%2584+%25D8%25AD%25D8%25AA%25D8%25A7%25D9%2585+%25D8%25AA%25D8%25BA%25D9%2581%25D9%2584_Page_3.jpg",
              child: Image.network(
                  fit: BoxFit.cover,
                  "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiwlqVwKry2d_Xb54RXjxEGBKP5okLfKCayZUWZ7FheoROo53kisEegIavCtvYySf6Ngxs6LXyZatZgJA-CAgFKF5fWB1pnOH-SlRViAo27JP4QzGVtIzdm-2quNrpviPESF8YEuYAH3Qk/s1600/%25D8%25A3%25D9%2588%25D8%25B1%25D8%25A7%25D9%2582+%25D8%25B9%25D9%2585%25D9%2584+%25D8%25AD%25D8%25AA%25D8%25A7%25D9%2585+%25D8%25AA%25D8%25BA%25D9%2581%25D9%2584_Page_3.jpg"),
            ),
          ),
        ),
      ),
    );
  }
}
