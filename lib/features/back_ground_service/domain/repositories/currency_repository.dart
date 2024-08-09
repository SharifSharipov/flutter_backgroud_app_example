import 'package:flutter_backgroud_app_example/core/failure/failure.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/data/models/currency_price.dart';

import '../../../../core/either/either.dart';

abstract class CurrencyRepository {
  Future<Either<Failure, List<CurrencyPrice>>>  getCurrencyPrice();
}