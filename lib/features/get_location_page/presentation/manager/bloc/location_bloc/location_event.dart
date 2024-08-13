part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

class GetLocationEvent extends LocationEvent {
  GetLocationEvent({required this.appLatLong});
  final AppLatLong appLatLong;
}

class FetchLocation extends LocationEvent {
  FetchLocation({required this.address});
  final String address;
}


