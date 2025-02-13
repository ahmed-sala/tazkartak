import 'package:flutter/material.dart';

class TicketsHistory extends StatelessWidget {
  const TicketsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tikets Hitory'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Tikets Hitory'),
      ),
    );
  }
}
