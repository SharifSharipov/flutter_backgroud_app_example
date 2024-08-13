/*
part of "upload_location_bloc.dart";

@immutable
abstract class UploadLocationEvent {}

class UploadLocationLoading extends UploadLocationEvent {}

class UploadLocationError extends UploadLocationEvent {}

class UploadLocationSuccess extends UploadLocationEvent {
  UploadLocationSuccess({
    required this.address,
    required this.entrance,
    required this.floor,
    required this.apartment,
    required this.referencePoint,
    required this.name,
  });

  final String address;
  final String entrance;
  final String floor;
  final String apartment;
  final String referencePoint;
  final String name;
}
*/
