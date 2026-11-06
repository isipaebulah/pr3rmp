class Trivia {
  final String ticker;
  final double price;
  final String exchange;

  Trivia({
    required this.ticker,
    required this.price,
    required this.exchange,
  });

  factory Trivia.fromJson(Map<String, dynamic> json) {
    return Trivia(
      ticker: json['ticker'] ?? '',
      price: (json['price'] as num).toDouble(),
      exchange: json['exchange'] ?? '',
    );
  }
}