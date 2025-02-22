import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// If using qr_flutter >= 5.0.0, import:
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/home/home_cubit.dart';

class SuccessScreen extends StatelessWidget {
  final String fromStation;
  final String toStation;

  final String price;
  final String numberOfStations;
  final String departureTime;
  final DateTime arrivalTime;

  const SuccessScreen({
    Key? key,
    required this.fromStation,
    required this.toStation,
    required this.price,
    required this.numberOfStations,
    required this.departureTime,
    required this.arrivalTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeCubit = context.read<HomeCubit>();
    var ticketsIds = [
      "123456",
      "234567",
      "345678",
      "456789",
      "567890",
      "678901",
      "789012",
      "890123",
      "901234",
      "012345",
      "111222",
      "222333",
      "333444",
      "444555",
      "555666",
      "666777",
      "777888",
      "888999",
      "999000",
      "000111",
      "135790",
      "246802",
      "987654",
      "876543",
      "765432",
      "654321",
      "543210",
      "102938",
      "564738",
      "019283",
      "102938",
      "564738",
      "019283",
      "847362",
      "726451",
      "615243",
      "504132",
      "908172",
      "817263",
      "726354",
      "635241",
      "524130",
      "413029",
      "302918",
      "291807",
      "180796",
      "069685",
      "958574",
      "847463",
      "736352"
    ];
    var random = new Random();
    var ticketId = ticketsIds[random.nextInt(ticketsIds.length)];

    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // Removing the default AppBar in favor of a custom header inside a gradient background.
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Custom Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirmation',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Your Ticket is Confirmed!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                // Ticket Details Card
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // From & Departure Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'From\n$fromStation',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Onboarding\n$departureTime Minute',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // To & Arrival Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'To\n$toStation',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Arrival\n${DateFormat('EEE h:mm').format(arrivalTime)}',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // QR Code & Ticket Information
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: QrImageView(
                                data: ticketId,
                                version: QrVersions.auto,
                                size: 100,
                                gapless: false,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Ticket ID',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    ticketId,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Price',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    'EGP $price',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Stations',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    '$numberOfStations station(s)',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 8),
                        // Total Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'EGP $price',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Done Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
