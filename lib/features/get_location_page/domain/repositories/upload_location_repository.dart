
import 'package:flutter_backgroud_app_example/features/get_location_page/domain/service/location_service.dart';

import '../../../../core/either/either.dart';
import '../../../../core/failure/failure.dart';
import '../../data/dio_settings/geo_code_response.dart';

abstract class UploadLocationRepository {

  Future<Either<Failure,LocationModel>> getLocationByAddress({required AppLatLong appLatLong});
}

