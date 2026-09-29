import '../../domain/entities/flight.dart';

class FlightModel extends Flight {
  new({
    required super.id,
    required super.airline,
    required super.flightNumber,
    required super.from,
    required super.to,
    required super.departure,
    required super.arrival,
    required super.price,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json['id'],
      airline: json['airline'],
      flightNumber: json['flightNumber'].toString(),
      from: json['from'],
      to: json['to'],
      departure: json['departure'],
      arrival: json['arrival'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
