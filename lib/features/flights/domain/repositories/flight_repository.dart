import 'package:app_mobile/features/flights/data/models/flight_model.dart';

abstract class FlightRepository {
  Future<List<FlightModel>> getFlights();
}
