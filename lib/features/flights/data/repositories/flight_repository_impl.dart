import 'package:app_mobile/features/flights/data/datasources/flight_local_datasource.dart';
import 'package:app_mobile/features/flights/data/models/flight_model.dart';
import 'package:app_mobile/features/flights/domain/repositories/flight_repository.dart';

class FlightRepositoryImpl extends FlightRepository {
  final FlightLocalDatasource dataSource;
  FlightRepositoryImpl(this.dataSource);

  @override
  Future<List<FlightModel>> getFlights() async {
    return await dataSource.getFlights();
  }
}
