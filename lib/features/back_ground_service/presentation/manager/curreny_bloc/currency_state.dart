part of 'currency_bloc.dart';



class CurrencyState extends Equatable {
  final FormzSubmissionStatus status;
  final List<CurrencyPrice> currencyPrice;
  final String message;

  const CurrencyState({
    this.status = FormzSubmissionStatus.initial,
    this.currencyPrice = const [],
    this.message = "",
  });

  CurrencyState copyWith({
    FormzSubmissionStatus? status,
    List<CurrencyPrice>? currencyPrice,
    String? message,
  }) {
    return CurrencyState(
      status: status ?? this.status,
      currencyPrice: currencyPrice ?? this.currencyPrice,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, currencyPrice, message];
}
