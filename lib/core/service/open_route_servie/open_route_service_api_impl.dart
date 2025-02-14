import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
import 'open_route_service_api.dart';

@Injectable(as: OpenRouteServiceApi)
class OpenRouteServiceApiImpl implements OpenRouteServiceApi {
  final String _url = 'https://api.openrouteservice.org/v2/directions/';
  final String _apiKey = '5b3ce3597851110001cf624860747fc7ae224b24a75d0bd0e8fea12a';
  final String _pathParam = 'driving-car';
  @override
  Future<ApiResult<List<LatLng>>> getRouteMaps({
    required double startLat,
    required double startLog,
    required double endLat,
    required double endLog,
  }) async {
    try {
      String urlOpenRouteService =
          "$_url/$_pathParam?api_key=$_apiKey&start=$startLog,$startLat&end=$endLog,$endLat";
      var response = await Dio().get(urlOpenRouteService);
      List<dynamic> coordinates =
          response.data['features'][0]['geometry']['coordinates'];
      List<LatLng> routePoints = coordinates
          .map((e) => LatLng(e[1] as double, e[0] as double)).toList();
      return Success(data: routePoints);
    } catch (e) {
      return Failures(exception: Exception("Error message: $e"));
    }
  }
}
