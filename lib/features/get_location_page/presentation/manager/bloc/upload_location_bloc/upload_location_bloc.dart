/*
import "package:equatable/equatable.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_clean_architecture/core/error/failure.dart";
import "package:flutter_clean_architecture/my/get_location_page/data/models/upload_address_model.dart";
import "package:flutter_clean_architecture/my/get_location_page/domain/repositories/upload_location_repository.dart";

part "upload_location_event.dart";

part "upload_location_state.dart";

class UploadLocationBloc extends Bloc<UploadLocationEvent, UploadLocationState> {
  UploadLocationBloc({required this.uploadLocationRepository}) : super(const UploadLocationState()) {
    on<UploadLocationSuccess>(_onUploadLocation);
  }

  final UploadLocationRepository uploadLocationRepository;

  Future<void> _onUploadLocation(UploadLocationSuccess event, Emitter<UploadLocationState> emit) async {
    emit(state.copyWith(uploadLocationStatus: UploadLocationStatus.loading));
    final result = await uploadLocationRepository.uploadLocation(
      address: event.address,
      entrance: event.entrance,
      floor: event.floor,
      apartment: event.apartment,
      referencePoint: event.referencePoint,
      name: event.name,
    );

    result.fold(
      (Failure failure) =>
          emit(state.copyWith(statusText: failure.message, uploadLocationStatus: UploadLocationStatus.error)),
      (UploadAddressModel uploadAddressModel) {
        print("success result fold");
        emit(state.copyWith(
            statusText: "Success",
            uploadLocationStatus: UploadLocationStatus.success,
            uploadAddressModel: uploadAddressModel));
      },
    );
  }
}
*/
