import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'location_manger.dart';

@Injectable(as: LocationManger)
class LocationMangerImpl implements LocationManger {
  Location location = Location();
  PermissionStatus permissionStatus = PermissionStatus.denied;
  @override
  Future<bool> canGetLocationPermission() async {
    bool isLocationPermissionGranted = await _isLocationPermissionGranted();
    bool isLocationServiceEnable = await _isLocationServiceEnable();
    return isLocationPermissionGranted && isLocationServiceEnable;
  }

  @override
  Future<LocationData> getLocationUser() async {
    return await location.getLocation();
  }

  Future<bool> _isLocationPermissionGranted() async {
    permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
      }
      return permissionStatus == PermissionStatus.granted ||
          permissionStatus == PermissionStatus.grantedLimited;
    }

    return permissionStatus == PermissionStatus.granted ||
        permissionStatus == PermissionStatus.grantedLimited;
  }

  Future<bool> _isLocationServiceEnable() async {
    var serviceLocationEnabled = await location.serviceEnabled();
    if (!serviceLocationEnabled) {
      serviceLocationEnabled = await location.requestService();
    }
    return serviceLocationEnabled;
  }

  @override
  Stream<LocationData> trackUserLocation() {
    return location.onLocationChanged;
  }
}
