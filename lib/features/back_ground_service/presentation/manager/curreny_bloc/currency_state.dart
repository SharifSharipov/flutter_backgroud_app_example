part of 'currency_bloc.dart';
enum CurrencyStatus { initial, loading, success, error }
@immutable
class CurrencyState  extends Equatable{
  final CurrencyStatus status;
  final List<CurrencyPrice> currencyPrice;
  final String message;
  const CurrencyState({
    this.status = CurrencyStatus.initial,
    this.currencyPrice = const [],
    this.message = "",
  });
  CurrencyState copyWith({
    CurrencyStatus? status,
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

