import 'package:flutter/material.dart';
import '../../../../mangers/section/tazkarat_view_model/core/metro_seclection_model.dart';
import 'item_metro_line_widget.dart';

class MetroListLineWidget extends StatelessWidget {
  final List<MetroStationModel> metroSelection;
  const MetroListLineWidget({super.key, required this.metroSelection});

  @override
  Widget build(BuildContext context) {
    return   Expanded(
      child: ListView.builder(
        itemCount: metroSelection.length,
        itemBuilder: (context, index) {
          final station = metroSelection[index];
          return ItemMetroLineWidget(station: station);
        },
      ),
    );
  }
}
