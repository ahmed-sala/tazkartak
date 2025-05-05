import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../mangers/auth/register/register_viewmodel.dart';

class GenderRadioButtonRow extends StatefulWidget {
  const GenderRadioButtonRow({super.key});

  @override
  State<GenderRadioButtonRow> createState() => _GenderRadioButtonRowState();
}

class _GenderRadioButtonRowState extends State<GenderRadioButtonRow> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterViewmodel>();
    return Row(
      children: [
        // Section Label
        const Text(
          'Gender',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 12),

        // Male option with blue styling
        Radio<Gender>(
          value: Gender.male,
          groupValue: viewModel.selectedGender,
          onChanged: (value) {
            setState(() {
              viewModel.selectedGender = value!;
            });
          },
          fillColor: MaterialStateProperty.all(Colors.black),
          activeColor: Colors.black,
        ),
        const Text(
          'Male',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 20),

        // Female option with pink styling
        Radio<Gender>(
          value: Gender.female,
          groupValue: viewModel.selectedGender,
          onChanged: (value) {
            setState(() {
              viewModel.selectedGender = value!;
            });
          },
          fillColor: MaterialStateProperty.all(Colors.black),
          activeColor: Colors.black,
        ),
        const Text(
          'Female',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ],
    );
  }
}
