// ignore_for_file: avoid_catches_without_on_clauses

import "package:dio/dio.dart";
import "package:equatable/equatable.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_backgroud_app_example/features/get_location_page/domain/repositories/upload_location_repository.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../../../../../core/either/either.dart";
import "../../../../../../core/failure/failure.dart";
import "../../../../data/dio_settings/geo_code_response.dart";
import "../../../../domain/service/location_service.dart";

part "location_event.dart";
part "location_state.dart";

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc({required this.locationRepository}) : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      emit(LocationLoading());
      try {
        final Either<Failure, LocationModel> result =
            await locationRepository.getLocationByAddress(appLatLong: event.appLatLong);
        result.fold((Failure failure) {
          emit(LocationError(error: failure.message));
        }, (LocationModel locationModel) {
          emit(LocationSucces(locationModel: locationModel));
        });
      } catch (e) {
        if (e is DioException) {
          emit(LocationError(error: e.response?.data["message"] ?? 'Unknown Dio error'));
        } else {
          emit(LocationError(error: e.toString()));
        }
      }
    });
  }
  final UploadLocationRepository locationRepository;

}
