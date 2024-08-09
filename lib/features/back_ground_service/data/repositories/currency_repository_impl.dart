import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_backgroud_app_example/core/either/either.dart';
import 'package:flutter_backgroud_app_example/core/failure/failure.dart';
import 'package:flutter_backgroud_app_example/core/server_error/server_error.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/data/models/currency_price.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/domain/repositories/currency_repository.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final Dio dio;
  CurrencyRepositoryImpl({required this.dio});

  @override
  Future<Either<Failure, List<CurrencyPrice>>> getCurrencyPrice() async {
    try {
      final Response<dynamic> response = await dio.get("https://nbu.uz/en/exchange-rates/json/");
      if (response.statusCode == 200) {
        return Right<Failure, List<CurrencyPrice>>(
            (response.data as List).map((e) => CurrencyPrice.fromJson(e)).toList()
        );
      } else {
        return Left<Failure, List<CurrencyPrice>>(
            ServerError.withError(message: "internal server error",code:response.statusCode ?? 500).failure
        );
      }
    } on DioException catch (dioError) {
      log("Dio Error occurred: $dioError");
      return Left<Failure, List<CurrencyPrice>>(
        ServerError.withDioError(error: dioError).failure,
      );
    } catch (error, stackTrace) {
      log("Unexpected error occurred: $error, StackTrace: $stackTrace");
      return Left<Failure, List<CurrencyPrice>>(
          ServerError.withError( message: 'error').failure
      );
    }
  }
}
