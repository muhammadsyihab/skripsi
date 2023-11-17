import 'dart:async';

import 'package:aneka/menu_operatorv2/location.dart';
import 'package:location/location.dart';

class LocationService{
  Location location = Location();
  StreamController<UserLocation> _LocationStramController = StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _LocationStramController.stream;

  LocationService(){
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
          _LocationStramController.add(UserLocation(latitude: locationData.latitude!,longtitude: locationData.longitude!));
          }
        });
      }
    });
  }
  void dispose() =>_LocationStramController.close();
}