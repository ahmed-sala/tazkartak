import 'package:flutter/material.dart';
// If using qr_flutter >= 5.0.0, import:
import 'package:qr_flutter/qr_flutter.dart';
// If using qr_flutter <= 4.x, import the older version and rename below.

class SuccessScreen extends StatelessWidget {
  final String fromStation;
  final String toStation;
  final String ticketId;
  final double price;
  final int numberOfStations;
  final String departureTime;
  final String arrivalTime;

  const SuccessScreen({
    Key? key,
    required this.fromStation,
    required this.toStation,
    required this.ticketId,
    required this.price,
    required this.numberOfStations,
    required this.departureTime,
    required this.arrivalTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If you are using qr_flutter version 4.x or below,
    // change QrImageView -> QrImage.

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Confirmation'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Your Ticket is Confirmed!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Ticket details card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // From & Onboarding
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'From\n$fromStation',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Onboarding\n$departureTime',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // To & Arrival
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'To\n$toStation',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Arrival\n$arrivalTime',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // QR Code & Ticket Info
                  Row(
                    children: [
                      // If using qr_flutter 5.0.0+, use QrImageView
                      // If older, replace QrImageView with QrImage
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
                              '\$${price.toStringAsFixed(2)}',
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

                  // Total row (if needed)
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
                        '\$${price.toStringAsFixed(2)}',
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
            const SizedBox(height: 24),

            // Done Button
            ElevatedButton(
              onPressed: () {
                // Close screen or navigate away
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
