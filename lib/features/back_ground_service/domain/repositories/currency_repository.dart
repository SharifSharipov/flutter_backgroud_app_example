import 'package:dartz/dartz.dart';
import 'package:flutter_backgroud_app_example/core/failure/failure.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/data/models/currency_price.dart';


abstract class CurrencyRepository {
  Future<Either<Failure, List<CurrencyPrice>>>  getCurrencyPrice();
}