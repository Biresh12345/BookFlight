import 'package:app_mobile/features/flights/domain/entities/flight.dart';
import 'package:app_mobile/features/flights/presentation/widget/flight_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/flight_provider.dart';

class FlightScreen extends ConsumerStatefulWidget {
  const FlightScreen({super.key});

  @override
  ConsumerState<FlightScreen> createState() => _FlightScreenState();
}

class _FlightScreenState extends ConsumerState<FlightScreen> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  List<Flight>? filteredFlights;

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  void searchFlights() {
    final flights = ref.read(flightsProvider).value ?? [];

    final result = ref
        .read(flightsProvider.notifier)
        .searchFlights(
          flights,
          fromController.text.trim(),
          toController.text.trim(),
        );

    setState(() {
      filteredFlights = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flightsState = ref.watch(flightsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Flights')),
      body: Column(
        children: [
          FlightSearchField(
            hintText: 'From',
            controller: fromController,
            prefixIcon: Icons.flight_takeoff,
          ),
          const SizedBox(height: 10),
          FlightSearchField(
            hintText: 'To',
            controller: toController,
            prefixIcon: Icons.flight_land,
          ),
          const SizedBox(height: 10),

          ElevatedButton(onPressed: searchFlights, child: const Text('Search')),

          const SizedBox(height: 10),
          Expanded(
            child: flightsState.when(
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              error: (error, stackTrace) {
                return Center(child: Text(error.toString()));
              },
              data: (flights) {
                final displayFlights = filteredFlights ?? flights;

                if (displayFlights.isEmpty) {
                  return const Center(child: Text('No flights found'));
                }
                return ListView.builder(
                  itemCount: displayFlights.length,
                  itemBuilder: (context, index) {
                    final flight = displayFlights[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.flight,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        flight.airline,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        flight.flightNumber,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '₹${flight.price.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        flight.departure,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        flight.from,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.flight_takeoff,
                                        size: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        height: 1,
                                        color: Colors.grey.shade300,
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        flight.arrival,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        flight.to,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            const Divider(),

                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Economy',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  'View Details',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
