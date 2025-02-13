import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tazkartak_app/core/dependency_injection/di.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/home/home_cubit.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/tazkarat_view_model/core/metro_seclection_model.dart';
import 'package:tazkartak_app/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:tazkartak_app/src/presentation/views/screens/home/widget/metro_drop_down_widget.dart';
import 'package:tazkartak_app/src/presentation/views/screens/home/widget/user_location_widget.dart';
import 'package:tazkartak_app/src/presentation/views/screens/success/success_screen.dart';
import 'package:tazkartak_app/src/tazkartak.dart';

import '../../../mangers/section/home/home_state.dart';

// In your HomeScreen widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? startStation;
  String? endStation;
  List<MetroStationModel> selectedStations = [];
  HomeCubit homeCubit = getIt<HomeCubit>();

  void findAndShowStations() {
    if (startStation != null && endStation != null) {
      setState(() {
        selectedStations = findStationsBetween(
          metroStationsThree,
          startStation!,
          endStation!,
        );
      });
    }
  }

  List<MetroStationModel> findStationsBetween(
    List<MetroStationModel> stations,
    String startStationName,
    String endStationName,
  ) {
    int startIndex = stations.indexWhere((s) => s.name == startStationName);
    int endIndex = stations.indexWhere((s) => s.name == endStationName);
    if (startIndex == -1 || endIndex == -1) {
      return [];
    }

    if (startIndex > endIndex) {
      final temp = startIndex;
      startIndex = endIndex;
      endIndex = temp;
    }

    final stationsBetween = stations.sublist(startIndex, endIndex + 1);
    for (var station in stationsBetween) {
      if (station.exchangeWithFonts.isNotEmpty) {
        debugPrint(
          "Station ${station.name} requires transfer to ${station.exchangeWithFonts}",
        );
      }
    }
    return stationsBetween;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.blueAccent,
        elevation: 3,
        shadowColor: Colors.grey.withOpacity(0.5),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
      ),
      // Wrap the body in a BlocConsumer to listen to payment states
      body: BlocProvider(
        create: (context) => homeCubit,
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is PaymentSuccessState) {
              // Show a success message
              navKey.currentState!.push(MaterialPageRoute(
                  builder: (context) => const SuccessScreen(
                      fromStation: 'Almalek',
                      toStation: 'Helwan',
                      ticketId: '1234',
                      price: 15,
                      numberOfStations: 20,
                      departureTime: '20 Min',
                      arrivalTime: '2 hours')));
              // Optionally, update the UI further if needed
            } else if (state is CancelPaymentState) {
              // Inform the user that payment was cancelled
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Payment Cancelled")),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nearest Metro Selection",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
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
                        const Text("Plan Your Trip",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        const Text(
                          "Fill in the details to get your trip ready.",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 15),
                        MetroDropdown(
                          metroStations: metroStationsThree,
                          onChanged: (value) {
                            setState(() {
                              startStation = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        MetroDropdown(
                          metroStations: metroStationsThree,
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
                            child: const Text("Confirm Trip",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (selectedStations.isNotEmpty) ...[
                          const Text("Stations in Your Route:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: selectedStations.length,
                            itemBuilder: (context, index) {
                              final station = selectedStations[index];
                              return ListTile(
                                title: Text(station.name),
                                subtitle: station.exchangeWithFonts.isNotEmpty
                                    ? Text(
                                        "Transfer to: ${station.exchangeWithFonts}")
                                    : null,
                                leading: const Icon(Icons.train,
                                    color: Colors.blueAccent),
                              );
                            },
                          ),
                        ],
                        const SizedBox(height: 20),
                        // Trigger payment on the same screen without navigation.
                        CustomAuthButton(
                          text: 'Go To Payment',
                          onPressed: () {
                            // This will show the payment sheet and wait for the result.
                            homeCubit.openStripePaymentSheet();
                          },
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
