import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInputField extends StatelessWidget {
  /// The currently selected date. If `null`, the widget shows 'Select Date'.
  final DateTime? selectedDate;

  /// Called when the user picks a date.
  final ValueChanged<DateTime> onDateSelected;

  /// The text displayed as the label for the input.
  final String labelText;

  /// The height of the container.
  final double height;

  const DateInputField({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
    this.labelText = 'Date Earned',
    this.height = 70.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // When tapped, display the date picker.
    return GestureDetector(
      onTap: () async {
        final DateTime initialDate = selectedDate ?? DateTime.now();
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(1900),
          lastDate: DateTime(2030),
        );
        if (pickedDate != null) {
          onDateSelected(pickedDate);
        }
      },
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            selectedDate != null
                ? DateFormat('M/d/yyyy').format(selectedDate!)
                : 'Select Date',
            style: TextStyle(
              color: selectedDate == null ? Colors.grey : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
