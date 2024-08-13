/*
part of "upload_location_bloc.dart";

enum UploadLocationStatus { initial, loading, success, error }

extension UploadLocationStatusExtension on UploadLocationStatus {
  bool get isLoading => this == UploadLocationStatus.loading;
  bool get isSuccess => this == UploadLocationStatus.success;
  bool get isError => this == UploadLocationStatus.error;
  bool get isInitial => this == UploadLocationStatus.initial;
}

@immutable
class UploadLocationState extends Equatable {
  const UploadLocationState({
    this.uploadLocationStatus = UploadLocationStatus.initial,
    this.statusText,
    this.uploadAddressModel,
  });

  final UploadLocationStatus uploadLocationStatus;
  final String? statusText;
  final UploadAddressModel? uploadAddressModel;

  UploadLocationState copyWith({
    UploadLocationStatus? uploadLocationStatus,
    String? statusText,
    UploadAddressModel? uploadAddressModel,
  }) =>
      UploadLocationState(
        uploadLocationStatus: uploadLocationStatus ?? this.uploadLocationStatus,
        statusText: statusText ?? this.statusText,
        uploadAddressModel: uploadAddressModel ?? this.uploadAddressModel,
      );

  @override
  List<Object?> get props => [
    uploadLocationStatus,
    statusText,
    uploadAddressModel,
  ];
}
*/
