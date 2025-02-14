import 'package:latlong2/latlong.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
abstract class OpenRouteServiceApi {
  Future<ApiResult<List<LatLng>>> getRouteMaps({
    required double startLat,
    required double startLog,
    required double endLat,
    required double endLog,
  });
}
