class Flight {
  final String id;
  final String airline;
  final String flightNumber;
  final String from;
  final String to;
  final String departure;
  final String arrival;
  final double price;

  const Flight({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.from,
    required this.to,
    required this.departure,
    required this.arrival,
    required this.price,
  });
}
