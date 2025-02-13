import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/home/home_cubit.dart';
import '../../../../../../../core/styles/colors/app_colore.dart';
import '../../../../../mangers/section/home/home_state.dart';

class MapBodyWidget extends StatefulWidget {
  const MapBodyWidget({super.key});

  @override
  State<MapBodyWidget> createState() => _MapBodyWidgetState();
}

class _MapBodyWidgetState extends State<MapBodyWidget> {
  @override
  Widget build(BuildContext context) {
    var homeCubit=BlocProvider.of<HomeCubit>(context);
    return     BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
              options: MapOptions(
                initialZoom: 10,
                maxZoom: 18,
                minZoom: 8,
                initialCenter: LatLng(homeCubit.userLatitude,homeCubit.userLongitude ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(markers: [
                  Marker(
                    width: 120,
                    point: LatLng(homeCubit.userLatitude,homeCubit.userLongitude ),
                      child: const Icon( Icons.location_on, color: Colors.red, size: 28,)
                  ),
                  Marker(
                    // height: 80,
                      width: 120,
                      point: LatLng(homeCubit.metroLatitude,homeCubit.metroLongitude ),
                      child: const Icon( Icons.location_on, color: Colors.green, size: 30,)
                  ),
                ]),
                homeCubit.routesPoint.isNotEmpty?
                PolylineLayer(
                    polylines: [
                      Polyline(
                        points: homeCubit.routesPoint, // تأكد من أنها List<LatLng>
                        strokeWidth: 3,
                        color: Colors.red),

                    ]): const SizedBox.shrink()


              ]
          ),
          InkWell(
            onTap:(){
              if(Navigator.canPop(context)){
                Navigator.pop(context);
              }
            },
            child:  const Padding(
              padding: EdgeInsets.all(20.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.arrow_back_ios_new,color: AppColors.greyColor,
                  size: 24,),

              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }


}
