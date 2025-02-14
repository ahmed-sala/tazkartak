import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/tazkarat_view_model/line_metro_cubit.dart';

import 'drop_down_menu_metro_item_widget.dart';

class CustomLineMetroFormFieldWidget extends StatelessWidget {
  const CustomLineMetroFormFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var lineMetroCubit=context.read<LineMetroCubit>();
    return BlocBuilder<LineMetroCubit, LineMetroState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => showDropDown(context,lineMetroCubit),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.blueAccent, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lineMetroCubit.selectedLine,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
              ],
            ),
          ),
        );
      },
    );
  }
  void showDropDown(BuildContext context , LineMetroCubit lineMetroCubit) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) =>  DropDownMenuMetroItemWidget(lineCubit:lineMetroCubit ,),
    );
  }

}
