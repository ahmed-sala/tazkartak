import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/home/home_cubit.dart';
import 'package:tazkartak_app/src/presentation/views/screens/home/widget/map_body_widget/map_body_widget.dart';

import '../../../../mangers/section/home/home_action.dart';
import '../../../../mangers/section/home/home_state.dart';

class UserLocationWidget extends StatelessWidget {
  const UserLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            viewModel.doAction(homeAction: GetLocationUserDataAction());
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 16),
              child: Row(
                children: [
               state is GetLocationUserLoadingState? const Center(child: CircularProgressIndicator()) : const Icon(
                      Icons.train, color: Colors.blueAccent, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          viewModel.nearestMetroStation,
                          style: TextStyle(color:
                          Colors.black87,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      NevigateToLocation(context);
                    },
                    child: const Icon(
                        Icons.location_on, color: Colors.red, size: 28),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void NevigateToLocation(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MapBodyWidget(),));
}
