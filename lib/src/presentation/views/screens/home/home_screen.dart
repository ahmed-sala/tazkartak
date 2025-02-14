import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/home/home_cubit.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/tazkarat_view_model/core/metro_seclection_model.dart';
import 'package:tazkartak_app/src/presentation/views/screens/home/widget/metro_drop_down_widget.dart';
import 'package:tazkartak_app/src/presentation/views/screens/home/widget/user_location_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MetroStationModel? startStation;
  MetroStationModel? endStation;
  int timeMetro = 0;
  ResultRouteMetro resultRouteMetro =
  const ResultRouteMetro(metro: [], message: "", price: "");

  void findAndShowStations() {
    if (startStation != null && endStation != null) {
      setState(() {
        resultRouteMetro = findStationsBetween(
          startMetroStation: startStation!,
          endMetroStation: endStation!,
        );
        timeMetro = resultRouteMetro.metro.length * 4;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var homeView = context.read<HomeCubit>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          "🚆 رحلتك في المترو",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nearest Metro Selection",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              const UserLocationWidget(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Plan Your Trip",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Fill in the details to get your trip ready.",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    MetroDropdown(
                      metroStations: homeView.metroStations,
                      onChanged: (value) {
                        setState(() {
                          startStation = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    MetroDropdown(
                      metroStations: homeView.metroStations,
                      onChanged: (value) {
                        setState(() {
                          endStation = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: findAndShowStations,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Confirm Trip",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (resultRouteMetro.metro.isNotEmpty &&
                  startStation?.name != endStation?.name) ...[
                ElevatedButton(
                  onPressed: () {
                    print(resultRouteMetro.metro[0].name);
                    print(resultRouteMetro.metro[resultRouteMetro.metro.length - 1].name);
                    print(resultRouteMetro.price);
                    print(timeMetro);
                  },
                  child: const Text("Pay"),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.blue[50],
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.attach_money, size: 24, color: Colors.green),
                                const SizedBox(width: 8),
                                Text(
                                  "السعر: ${resultRouteMetro.price} جنيه",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 24, color: Colors.blue),
                                const SizedBox(width: 8),
                                Text(
                                  "الوقت: $timeMetro دقيقة",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "📍 المسار المتوقع:",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: resultRouteMetro.metro.length,
                  itemBuilder: (context, index) {
                    final station = resultRouteMetro.metro[index];
                    final bool isTransfer = resultRouteMetro.message.contains(station.name);

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isTransfer ? Colors.orange[100] : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Icon(
                          isTransfer ? Icons.compare_arrows_rounded : Icons.train,
                          color: isTransfer ? Colors.red : const Color(0xFF7B61FF),
                          size: 28,
                        ),
                        title: Text(
                          station.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: isTransfer ? FontWeight.bold : FontWeight.normal,
                            color: isTransfer ? Colors.red : Colors.black,
                          ),
                        ),
                        subtitle: isTransfer
                            ? const Text(
                          "⚠️ محطة تحويل، انتبه للتغيير",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        )
                            : null,
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
