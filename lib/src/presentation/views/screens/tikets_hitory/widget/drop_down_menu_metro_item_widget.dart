import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/tazkarat_view_model/line_metro_cubit.dart';

class DropDownMenuMetroItemWidget extends StatelessWidget {
  final LineMetroCubit lineCubit;
  const DropDownMenuMetroItemWidget({super.key, required this.lineCubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.sp), // يضيف تنسيق للشاشة
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2),
        ],
      ),
      padding: EdgeInsets.all(16.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.sp,
            height: 4.sp,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 10.sp),
          Text(
            "Select Metro Line",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          SizedBox(height: 10.sp),
          ListView.separated(
            shrinkWrap: true,
            itemCount: lineCubit.lines.length,
            separatorBuilder: (_, __) => Divider(color: Colors.grey[300]),
            itemBuilder: (context, index) {
              final line = lineCubit.lines[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.sp),
                title: Text(
                  line,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
                ),
                onTap: () {
                   lineCubit.setSelectionLine(line: line);
                  Navigator.pop(context);


                },
                trailing: lineCubit.selectedLine == line
                    ? const Icon(Icons.check_circle, color: Colors.blueAccent)
                    : const Icon(Icons.circle_outlined, color: Colors.grey),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                tileColor:lineCubit. selectedLine == line ? Colors.blue.withOpacity(0.1) : Colors.transparent,
              );
            },
          ),
          SizedBox(height: 10.sp),
        ],
      ),
    );
  }
}
