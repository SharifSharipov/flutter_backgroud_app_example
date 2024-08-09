class CurrencyPriceFields {
  static const String title = "title";
  static const String code = "code";
  static const String cbPrice = "cb_price";
  static const String nbuBuyPrice = "nbu_buy_price";
  static const String nbuCellPrice = "nbu_cell_price";
  static const String date = "date";
}

class CurrencyPrice {
  final String title;
  final String code;
  final String cbPrice;
  final String nbuBuyPrice;
  final String nbuCellPrice;
  final String date;

  CurrencyPrice(
      {required this.title,
      required this.code,
      required this.cbPrice,
      required this.nbuBuyPrice,
      required this.nbuCellPrice,
      required this.date});

  CurrencyPrice copyWith(
          {String? title, String? code, String? cbPrice, String? nbuBuyPrice, String? nbuCellPrice, String? date}) =>
      CurrencyPrice(
          title: title ?? this.title,
          code: code ?? this.code,
          cbPrice: cbPrice ?? this.cbPrice,
          nbuBuyPrice: nbuBuyPrice ?? this.nbuBuyPrice,
          nbuCellPrice: nbuCellPrice ?? this.nbuBuyPrice,
          date: date ?? this.date);

  factory CurrencyPrice.fromJson(Map<String, dynamic> json) {
    return CurrencyPrice(
      title: json[CurrencyPriceFields.title] as String? ?? "",
      code: json[CurrencyPriceFields.code] as String? ?? "",
      cbPrice: json[CurrencyPriceFields.cbPrice] as String? ?? "",
      nbuBuyPrice: json[CurrencyPriceFields.nbuBuyPrice] as String? ?? "",
      nbuCellPrice: json[CurrencyPriceFields.nbuCellPrice] as String? ?? "",
      date: json[CurrencyPriceFields.date] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        CurrencyPriceFields.title: title,
        CurrencyPriceFields.code: code,
        CurrencyPriceFields.cbPrice: cbPrice,
        CurrencyPriceFields.nbuBuyPrice: nbuBuyPrice,
        CurrencyPriceFields.nbuCellPrice: nbuCellPrice,
        CurrencyPriceFields.date: date,
      };
}
