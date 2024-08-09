import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_backgroud_app_example/core/failure/failure.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/data/models/currency_price.dart';
import 'package:flutter_backgroud_app_example/features/back_ground_service/domain/repositories/currency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
// part 'currency_event.dart';

part 'currency_state.dart';

// class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
//   CurrencyBloc(this.currencyRepository) : super(const CurrencyState()) {
//     on<SuccessGetCurrencyPriceEvent>(_getCurrencyPrice);
//   }
//
//   final CurrencyRepository currencyRepository;
//
//   Future<void> _getCurrencyPrice(SuccessGetCurrencyPriceEvent event, Emitter<CurrencyState> emit) async {
//     emit(state.copyWith(status: CurrencyStatus.loading));
//     final Either<Failure, List<CurrencyPrice>> result = await currencyRepository.getCurrencyPrice();
//     result.fold(
//       (failure) => emit(state.copyWith(status: CurrencyStatus.error, message: failure.message)),
//       (currencyPrice) => emit(state.copyWith(status: CurrencyStatus.success, currencyPrice: currencyPrice)),
//     );
//   }
// }

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit(this.currencyRepository) : super(const CurrencyState());

  final CurrencyRepository currencyRepository;

  Future<void> getCurrencyPrice() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final Either<Failure, List<CurrencyPrice>> result = await currencyRepository.getCurrencyPrice();
    result.fold(
      (failure) => emit(state.copyWith(status: FormzSubmissionStatus.failure, message: failure.message)),
      (currencyPrice) => emit(state.copyWith(status: FormzSubmissionStatus.success, currencyPrice: currencyPrice)),
    );
  }
}
