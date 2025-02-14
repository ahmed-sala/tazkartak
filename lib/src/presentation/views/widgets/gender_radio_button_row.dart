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
        Text(
          'Gender',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Radio<Gender>(
          fillColor: MaterialStateProperty.all(Colors.white),
          activeColor: Colors.white,
          value: Gender.male,
          groupValue: viewModel.selectedGender,
          onChanged: (value) {
            setState(() {
              viewModel.selectedGender = value!;
            });
          },
        ),
        Text(
          'Male',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Radio<Gender>(
          fillColor: MaterialStateProperty.all(Colors.white),
          activeColor: Colors.white,
          value: Gender.female,
          groupValue: viewModel.selectedGender,
          onChanged: (value) {
            setState(
              () {
                viewModel.selectedGender = value!;
              },
            );
          },
        ),
        Text(
          'Female',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
