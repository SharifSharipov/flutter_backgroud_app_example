part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSucces extends Equatable implements LocationState {
  const LocationSucces({required this.locationModel});

  final LocationModel locationModel;

  @override
  List<Object?> get props => [locationModel];
}

final class LocationError extends LocationState {
  LocationError({required this.error});

  final String error;
}
final class AddLocation extends LocationState{
}
final class AddLocationError extends LocationState{
  AddLocationError({required this.error});
  final String error;
}
/*
final class AddLocationSuccess extends LocationState{
  AddLocationSuccess({required this.uploadAddressModel});
  final UploadAddressModel uploadAddressModel;

}*/
