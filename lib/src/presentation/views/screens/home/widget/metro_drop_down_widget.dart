import 'package:flutter/material.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/tazkarat_view_model/core/metro_seclection_model.dart';

class MetroDropdown extends StatefulWidget {
  final List<MetroStationModel> metroStations;
  final Function(String?)? onChanged;

  const MetroDropdown({super.key, required this.metroStations, this.onChanged});

  @override
  State<MetroDropdown> createState() => _MetroDropdownState();
}

class _MetroDropdownState extends State<MetroDropdown> {
  String? selectedStation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedStation,
        hint: const Text("Select a Metro Station"),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        items: widget.metroStations.map((e) {
          return DropdownMenuItem(
            value: e.name,
            child: Row(
              children: [
                const Icon(Icons.train, color: Colors.blueAccent, size: 20),
                const SizedBox(width: 10),
                Text(e.name, style: const TextStyle(fontSize: 16)),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedStation = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
