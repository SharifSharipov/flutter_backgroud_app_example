import "dart:async";
import "package:flutter/material.dart";
import "package:yandex_mapkit/yandex_mapkit.dart";
import "package:yandex_mapkit/yandex_mapkit.dart" as yandex;
import "package:yandex_mapkit/yandex_mapkit.dart";

import "../../../../core/icons/app_icons.dart";
import "../../domain/service/location_service.dart";
import "get_location_page.dart";

mixin GetLocationPageMixin on State<GetLocationPage> {
  final Completer<yandex.YandexMapController> mapControllerCompleter = Completer<yandex.YandexMapController>();
  final TextEditingController textEditingController = TextEditingController();
  List<yandex.MapObject> mapObjects = <yandex.MapObject>[];
  AppLatLong appLatLong = const TashkentLocation();
  yandex.PlacemarkMapObject? currentMarker;
  late String addressDetail = "SelectLocation";
  List<AppLatLong> uzbekistanMaxWayLocations = const [
    AppLatLong(lat: 41.2995, long: 69.2401), // Tashkent, Amir Temur ko'chasi
    AppLatLong(lat: 41.3275, long: 69.2495), // Tashkent, Chilonzor tuman
    AppLatLong(lat: 41.3111, long: 69.2793), // Tashkent, Shayxontohur tuman
    AppLatLong(lat: 41.3122, long: 69.2944), // Tashkent, Mustaqillik maydoni yaqinida
    AppLatLong(lat: 41.3112, long: 69.2204), // Tashkent, Mirzo Ulug'bek tuman
    AppLatLong(lat: 40.7860, long: 72.3442), // Andijon
    AppLatLong(lat: 41.0083, long: 71.6726), // Farg'ona
    AppLatLong(lat: 40.1126, long: 67.8310), // Jizzax
    AppLatLong(lat: 39.6542, long: 66.9442), // Samarqand
    AppLatLong(lat: 40.3914, long: 71.7873), // Namangan
  ];

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
    _addMarkersFromList(uzbekistanMaxWayLocations);
  }

  double get height => MediaQuery.of(context).size.height;

  double get width => MediaQuery.of(context).size.width;

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const TashkentLocation defLocation = TashkentLocation();
    try {
      location = await LocationService().getCurrentLocation();
    }
    // ignore: avoid_catches_without_on_clauses
    catch (e) {
      location = defLocation;
    }
    location = defLocation;
    await _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(AppLatLong currentLocation) async {
    await (await mapControllerCompleter.future).moveCamera(
      animation: const yandex.MapAnimation(type: yandex.MapAnimationType.linear, duration: 1),
      yandex.CameraUpdate.newCameraPosition(
        yandex.CameraPosition(
          target: yandex.Point(
            latitude: currentLocation.lat,
            longitude: currentLocation.long,
          ),
          zoom: 14,
        ),
      ),
    );
  }

  void addMarker({required AppLatLong appLatLong}) {
    final yandex.PlacemarkMapObject newMarker = yandex.PlacemarkMapObject(
      opacity: 1,
      mapId: const yandex.MapObjectId("currentLocation"),
      point: yandex.Point(
        latitude: appLatLong.lat,
        longitude: appLatLong.long,
      ),
      icon: yandex.PlacemarkIcon.single(
        yandex.PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(AppImages.currentStatus),
          rotationType: yandex.RotationType.rotate,
        ),
      ),
    );

    setState(() {
      mapObjects
        ..removeWhere((yandex.MapObject element) => element.mapId.value == "currentLocation")
        ..add(newMarker);
    });
  }

  void updateMarker({required AppLatLong appLatLong}) {
    final yandex.PlacemarkMapObject newMarker = yandex.PlacemarkMapObject(
      opacity: 1,
      mapId: const yandex.MapObjectId("secondLocation"),
      point: yandex.Point(
        latitude: appLatLong.lat,
        longitude: appLatLong.long,
      ),
      icon: yandex.PlacemarkIcon.single(
        yandex.PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(AppImages.currentStatus),
          rotationType: yandex.RotationType.rotate,
        ),
      ),
    );

    setState(() {
      mapObjects
        ..removeWhere((yandex.MapObject element) => element.mapId.value == "secondLocation")
        ..add(newMarker);
    });
  }

  Future<void> _searchLocation() async {
    const AppLatLong searchedLocation = AppLatLong(lat: 55.751244, long: 37.618423);
    await _moveToCurrentLocation(searchedLocation);
    updateMarker(appLatLong: searchedLocation);
  }

  void _addMarkersFromList(List<AppLatLong> moscowLocations) {
    for (int i = 0; i < moscowLocations.length; i++) {
      final yandex.PlacemarkMapObject newMarker = yandex.PlacemarkMapObject(
        opacity: 1,
        mapId: yandex.MapObjectId("id$i"),
        point: yandex.Point(
          latitude: moscowLocations[i].lat,
          longitude: moscowLocations[i].long,
        ),
        icon: yandex.PlacemarkIcon.single(
          yandex.PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(AppImages.currentStatus),
            rotationType: yandex.RotationType.rotate,
          ),
        ),
      );
      mapObjects.add(newMarker);
    }
    setState(() {});
  }
}
