
import 'package:geolocator/geolocator.dart';

abstract class AppLocation {
  Future<AppLatLong> getCurrentLocation();
  Future<bool> requestPermission();
  Future<bool> checkPermission();
}

class LocationService implements AppLocation {
  final defLocation = const TashkentLocation();
  @override
  Future<AppLatLong> getCurrentLocation() async => Geolocator.getCurrentPosition()
      .then((value) => AppLatLong(lat: value.latitude, long: value.longitude))
      .catchError(
        (_) => defLocation,
  );
  @override
  Future<bool> requestPermission() => Geolocator.requestPermission()
      .then((value) => value == LocationPermission.always || value == LocationPermission.whileInUse)
      .catchError((_) => false);
  @override
  Future<bool> checkPermission() => Geolocator.checkPermission()
      .then((value) => value == LocationPermission.always || value == LocationPermission.whileInUse)
      .catchError((_) => false);
}

class AppLatLong {
  const AppLatLong({
    required this.lat,
    required this.long,
  });
  factory AppLatLong.fromJson(Map<String, dynamic> json) => AppLatLong(
    lat: json["lat"],
    long: json["long"],
  );
  final double lat;
  final double long;
  Map<String,dynamic>toJson()=>{
    "lat":lat,
    "long":long
  };
}

class TashkentLocation extends AppLatLong {
  const TashkentLocation({
    super.lat =  41.345570,
    super.long = 69.284599,
  });
}
