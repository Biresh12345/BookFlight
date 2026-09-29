import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/flight_local_datasource.dart';
import '../../data/repositories/flight_repository_impl.dart';
import '../../domain/entities/flight.dart';
import '../../domain/usecases/get_flights.dart';

final flightLocalDataSourceProvider = Provider<FlightLocalDatasource>((ref) {
  return FlightLocalDatasource();
});

final flightRepositoryProvider = Provider<FlightRepositoryImpl>((ref) {
  return FlightRepositoryImpl(ref.read(flightLocalDataSourceProvider));
});

final getFlightsProvider = Provider<GetFlights>((ref) {
  return GetFlights(ref.read(flightRepositoryProvider));
});

final flightsProvider = AsyncNotifierProvider<FlightsNotifier, List<Flight>>(
  FlightsNotifier.new,
);

class FlightsNotifier extends AsyncNotifier<List<Flight>> {
  @override
  Future<List<Flight>> build() async {
    return ref.read(getFlightsProvider).call();
  }

  List<Flight> searchFlights(List<Flight> flights, String from, String to) {
    return flights.where((flight) {
      return flight.from.toLowerCase() == from.toLowerCase() &&
          flight.to.toLowerCase() == to.toLowerCase();
    }).toList();
  }
}
