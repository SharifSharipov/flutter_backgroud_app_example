import "dart:developer";
import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";
import "../../../../constants/time_constants.dart";
import "../../../../core/either/either.dart";
import "../../../../core/failure/failure.dart";
import "../../../../core/server_error/server_error.dart";
import "../../domain/repositories/upload_location_repository.dart";
import "../../domain/service/location_service.dart";
import "../dio_settings/geo_code_response.dart";


class UploadLocationRepositoryImpl implements UploadLocationRepository {
  UploadLocationRepositoryImpl({required this.dio});

  final Dio dio;
  final TextEditingController controller = TextEditingController();

  @override
  Future<Either<Failure, LocationModel>> getLocationByAddress({
    required AppLatLong appLatLong,
  }) async {
    try {
      final response = await dio.get(
        "https://geocode-maps.yandex.ru/1.x/?apikey=${AppConstants.apiKey}&geocode=${appLatLong.lat},${appLatLong.long}&format=json",
      );
      if (response.statusCode == 200) {
        return Right<Failure, LocationModel>(LocationModel.fromJson(response.data));
      } else {
        return Left<Failure, LocationModel>(
          ServerError.withError(message: "Unexpected status code: ${response.statusCode}").failure,
        );
      }
    } on DioError catch (error) {
      log("Dio Error occurred: $error");
      return Left<Failure, LocationModel>(
        ServerError.withDioError(error: error).failure,
      );
    } on Exception catch (error, stackTrace) {
      log("Unexpected error occurred: $error, StackTrace: $stackTrace");
      return Left<Failure, LocationModel>(
        ServerError.withError(message: error.toString()).failure,
      );
    }
  }
}
