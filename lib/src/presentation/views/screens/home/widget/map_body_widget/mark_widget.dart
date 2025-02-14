import 'package:flutter/material.dart';
class MarkWidget extends StatelessWidget {
  final  String text;
  final String image;
  const MarkWidget({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return   Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      decoration: BoxDecoration(
          color: const Color(0xFFD21E6A), borderRadius: BorderRadius.circular(50)),
      child:Icon(Icons.arrow_back,)

    );
  }
}
