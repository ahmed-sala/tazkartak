import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tazkartak_app/src/presentation/views/screens/tikets_hitory/line_metro.dart';

import '../../../../mangers/section/tazkarat_view_model/core/metro_seclection_model.dart';

class ItemMetroLineWidget extends StatelessWidget {
  final MetroStationModel station;
  const ItemMetroLineWidget({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 12.sp),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            tileColor: Colors.white,
            title: Text(
              station.name,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.train, color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
            onTap: () {
              // اضف التنقل لتفاصيل المحطة
            },
          )
      ),
    );
  }
}
