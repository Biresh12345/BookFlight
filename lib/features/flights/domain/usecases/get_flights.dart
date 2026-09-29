import 'package:app_mobile/features/flights/domain/entities/flight.dart';
import 'package:app_mobile/features/flights/domain/repositories/flight_repository.dart';

class GetFlights {
  final FlightRepository repository;
  GetFlights(this.repository);
  Future<List<Flight>> call() async {
    return await repository.getFlights();
  }
}
