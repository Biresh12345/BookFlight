import 'dart:convert';

import 'package:app_mobile/features/flights/data/models/flight_model.dart';
import 'package:flutter/services.dart';

class FlightLocalDatasource {
  Future<List<FlightModel>> getFlights() async {
    final jsonString = await rootBundle.loadString('assets/json/flights.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);
    Future.delayed(Duration(seconds: 1));
    return jsonData.map((json) => FlightModel.fromJson(json)).toList();
  }
}
