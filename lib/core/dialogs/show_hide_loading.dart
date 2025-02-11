import 'package:flutter/material.dart';

import '../../src/tazkartak.dart';

showLoading(BuildContext context, String? message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        text: message,
      );
    },
  );
}

hideLoading() {
  if (navKey.currentState!.canPop()) {
    Navigator.of(navKey.currentContext!).pop();
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, this.text});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            width: 16,
          ),
          Text(text!),
        ],
      ),
    );
  }
}
