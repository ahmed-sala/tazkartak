import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tazkartak_app/core/dialogs/awesome_dialoge.dart';
import 'package:tazkartak_app/src/data/models/ticket_model.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/home/home_cubit.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/tazkarat_view_model/core/metro_seclection_model.dart';
import 'package:tazkartak_app/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:tazkartak_app/src/presentation/views/screens/home/widget/metro_drop_down_widget.dart';
import 'package:tazkartak_app/src/presentation/views/screens/home/widget/user_location_widget.dart';

import '../../../../../core/dialogs/show_hide_loading.dart';
import '../../../../tazkartak.dart';
import '../../../mangers/section/home/home_state.dart';
import '../success/success_screen.dart';

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

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade300],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "Metro Journey",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section with current location
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(bottom: 20.h),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Plan Your Metro Trip",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const Text(
                        "Select your starting and destination stations.",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 15.h),
                      const UserLocationWidget(),
                    ],
                  ),
                ),
              ),
              // Trip Planner Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(bottom: 20.h),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MetroDropdown(
                        metroStations: homeView.metroStations,
                        onChanged: (value) {
                          setState(() {
                            startStation = value;
                          });
                        },
                      ),
                      SizedBox(height: 15.h),
                      MetroDropdown(
                        metroStations: homeView.metroStations,
                        onChanged: (value) {
                          setState(() {
                            endStation = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: findAndShowStations,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Confirm Trip",
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Result Section (if available)
              if (resultRouteMetro.metro.isNotEmpty &&
                  startStation?.name != endStation?.name &&
                  resultRouteMetro.metro.length > 1) ...[
                BlocListener<HomeCubit, HomeState>(
                  listener: (context, state) async {
                    if (state is PaymentSuccessState) {
                      // Navigate to the success screen on successful payment
                      TicketModel ticket = TicketModel(
                        fromStation: resultRouteMetro.metro.first.name,
                        toStation: resultRouteMetro.metro.last.name,
                        price: resultRouteMetro.price,
                        noOfStations: resultRouteMetro.metro.length.toString(),
                      );

                      await homeView.storeTicket(ticket);
                    } else if (state is CancelPaymentState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Payment Cancelled")),
                      );
                    } else if (state is SaveTiketSuccessState) {
                      hideLoading();
                      navKey.currentState!.push(MaterialPageRoute(
                          builder: (context) => SuccessScreen(
                                fromStation: resultRouteMetro.metro.first.name,
                                toStation: resultRouteMetro.metro.last.name,
                                price: resultRouteMetro.price,
                                numberOfStations:
                                    resultRouteMetro.metro.length.toString(),
                                departureTime: timeMetro.toString(),
                                arrivalTime: DateTime.now()
                                    .add(Duration(minutes: timeMetro)),
                              )));
                    } else if (state is SaveTiketFailuresState) {
                      hideLoading();
                      showAwesomeDialog(context,
                          title: 'Error',
                          desc: state.errorMassage,
                          onOk: () {},
                          dialogType: DialogType.error);
                    } else if (state is SaveTiketLoadingState) {
                      showLoading(context, 'Saving Ticket...');
                    }
                  },
                  child: CustomAuthButton(
                    text: 'Go To Payment',
                    onPressed: () {
                      homeView.openStripePaymentSheet();
                    },
                    color: Colors.deepPurpleAccent,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20.h),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.attach_money,
                                size: 28, color: Colors.green),
                            SizedBox(width: 8.w),
                            Text(
                              "Price: ${resultRouteMetro.price} EGP",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                size: 28, color: Colors.blue),
                            SizedBox(width: 8.w),
                            Text(
                              "Time: $timeMetro mins",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Expected Route:",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: resultRouteMetro.metro.length,
                  itemBuilder: (context, index) {
                    final station = resultRouteMetro.metro[index];
                    final bool isTransfer =
                        resultRouteMetro.message.contains(station.name);
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: BoxDecoration(
                        color:
                            isTransfer ? Colors.orange.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(
                          isTransfer
                              ? Icons.compare_arrows_rounded
                              : Icons.train,
                          color: isTransfer ? Colors.red : Colors.deepPurple,
                          size: 30,
                        ),
                        title: Text(
                          station.name,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: isTransfer
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isTransfer ? Colors.red : Colors.black,
                          ),
                        ),
                        subtitle: isTransfer
                            ? const Text(
                                "Transfer Station",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
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

/// Formats a [DateTime] to a string showing abbreviated day and time.
/// For example: "Mon, 08:30 AM"
String formatDateTime(DateTime dateTime) {
  return DateFormat('EEE, hh:mm a').format(dateTime);
}

/// Formats a duration given in minutes. If less than 60, it shows minutes only.
/// Otherwise, it shows hours and remaining minutes.
/// For example:
///   45 -> "45 mins"
///   75 -> "1 hr 15 mins"
String formatDuration(int minutes) {
  if (minutes < 60) {
    return '$minutes mins';
  } else {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    if (remainingMinutes == 0) {
      return '$hours hr${hours > 1 ? 's' : ''}';
    }
    return '$hours hr${hours > 1 ? 's' : ''} $remainingMinutes mins';
  }
}
