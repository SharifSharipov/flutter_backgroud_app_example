part of 'currency_bloc.dart';

@immutable
sealed class CurrencyEvent {}
class LoadingGetCurrencyPriceEvent extends CurrencyEvent{}
class ErrorGetCurrencyPriceEvent extends CurrencyEvent{}
class SuccessGetCurrencyPriceEvent extends CurrencyEvent{}