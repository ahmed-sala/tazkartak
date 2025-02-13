import 'package:location/location.dart';
abstract class LocationManger {
  Future<bool> canGetLocationPermission();
  Future<LocationData> getLocationUser();
  Stream<LocationData> trackUserLocation();
}