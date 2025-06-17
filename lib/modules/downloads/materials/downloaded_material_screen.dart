
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/modules/lessons/view/screens/lesson_details_screen.dart';
import 'package:my_project_new/modules/lessons/view/screens/lessonss_screen.dart';



import '../../../constant/app_colors.dart';
import '../../../widgets/app_scaffold.dart';
import '../../lessons/models/lesson.dart';
import 'downloaded_material_cubit.dart';
import 'downloaded_material_state.dart';

class DownloadedMaterialScreen extends StatefulWidget {
  final int? id;
  final String title;
  final DownloadedMaterialType type;

  const DownloadedMaterialScreen({Key? key, this.id,required this.title,
   required this.type}) : super(key: key);

  @override
  State<DownloadedMaterialScreen> createState() => _DownloadedMaterialScreenState();
}

class _DownloadedMaterialScreenState extends State<DownloadedMaterialScreen> {
  DownloadedMaterialCubit downloadedMaterialCubit = DownloadedMaterialCubit();
   Map<String,dynamic> attributes = {};
  @override
  void initState() {
    if(widget.type == DownloadedMaterialType.subject){
      downloadedMaterialCubit.getSubjects();
    }else if(widget.type == DownloadedMaterialType.unit){
      downloadedMaterialCubit.getUnits(widget.id!);

    }else{
      downloadedMaterialCubit.getLessons(widget.id!);

    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.type == DownloadedMaterialType.subject){
      attributes['padding'] = EdgeInsets.symmetric(vertical: 2.h);
      attributes['color'] = AppColors.WHITE;
    }else if(widget.type == DownloadedMaterialType.unit){
      attributes['padding'] = EdgeInsets.symmetric(vertical: 2.h);
      attributes['color'] = AppColors.SECONDRY;
      attributes['font_color'] = AppColors.WHITE;

    }else{
      attributes['padding'] = EdgeInsets.symmetric(vertical: 2.h);
      attributes['color'] = AppColors.PRIMARY;
      attributes['font_color'] = AppColors.WHITE;
    }
    return  AppScaffold(
      title: '',
      body: BlocProvider(
        create: (context) =>downloadedMaterialCubit,

        child: BlocBuilder<DownloadedMaterialCubit,DownloadedMaterialState>(
            builder: (context,state) {
              if(state is DownloadedMaterialSuccess) {
                return Column(
                  children: [
                    Text( widget.title),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        separatorBuilder: (context, index) => SizedBox(height: 3.h,),
                        itemCount: downloadedMaterialCubit.materials.length,
                          itemBuilder: (context, index) =>
                              InkWell(
                                onTap: (){

                                  switch(widget.type){
                                    case DownloadedMaterialType.subject:  Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DownloadedMaterialScreen(title: 'الوحدات',
                                                type: DownloadedMaterialType.unit,id: downloadedMaterialCubit.materials[index].id,),
                                        )
                                    );
                                    break;
                                    case DownloadedMaterialType.unit:
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DownloadedMaterialScreen(title: 'الدروس',
                                                  type: DownloadedMaterialType.lesson,
                                                  id: downloadedMaterialCubit.materials[index].id,),
                                          )
                                      );
                                      break;
                                    case DownloadedMaterialType.lesson:
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LessonDetailsScreen(
                                                  id: downloadedMaterialCubit.materials[index].id,
                                                  name: downloadedMaterialCubit.materials[index].title,
                                                  unitId: downloadedMaterialCubit.materials[index].parent!,

                                                ),
                                          )
                                      );
                                      break;
                                    default:

                                  }

                                },
                                child:Card(
                                  color:attributes['color'], // Change to any color you like
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      downloadedMaterialCubit.materials[index].title,
                                      style:  TextStyle(
                                        color: attributes['font_color'] ,

                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                              )),
                    ),
                  ],
                );
              }else{
                return const SizedBox();
              }
            }
        ),

      ),


    );
  }
}