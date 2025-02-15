import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tazkartak_app/core/styles/spacing.dart';
import 'package:tazkartak_app/src/presentation/views/screens/tikets_hitory/widget/custom_line_metro_form_feild_widget.dart';
import 'package:tazkartak_app/src/presentation/views/screens/tikets_hitory/widget/metro_list_line_widget.dart';

import '../../../mangers/section/tazkarat_view_model/line_metro_cubit.dart';

class LineMetro extends StatefulWidget {
  const LineMetro({Key? key}) : super(key: key);

  @override
  State<LineMetro> createState() => _LineMetroState();
}

class _LineMetroState extends State<LineMetro> {
  final lineMetroCubit = LineMetroCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => lineMetroCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Metro Tazkartak',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          elevation: 3,
          shadowColor: Colors.grey.withOpacity(0.5),
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade700,
                Colors.deepPurple.shade300,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BlocBuilder<LineMetroCubit, LineMetroState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(16.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.only(bottom: 20.h),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Know Metro Tazkartak",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            verticalSpace(8),
                            Text(
                              "Choose the line and we will tell you all the sections.",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Custom Form Field Card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: const CustomLineMetroFormFieldWidget(),
                      ),
                    ),
                    verticalSpace(16),
                    // Show Metro List if a line is selected
                    lineMetroCubit.selectedLine == "Choose The  Line"
                        ? const SizedBox.shrink()
                        : Expanded(
                            child: MetroListLineWidget(
                              metroSelection: lineMetroCubit.metroSelection,
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
