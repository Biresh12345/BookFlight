import 'package:app_mobile/features/flights/presentation/providers/nav_provider.dart';
import 'package:app_mobile/features/flights/presentation/screens/flight_screen.dart';
import 'package:app_mobile/features/flights/presentation/widget/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navProvider = NotifierProvider<NavProvider, int>(NavProvider.new);

class HomeScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navProvider);
    final screenList = [
      const FlightScreen(),
      const Placeholder(),
      const Placeholder(),
    ];
    return Scaffold(
      body: screenList[index],
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: index,
        onTap: (value) {
          ref.read(navProvider.notifier).updateIndex(value);
        },
      ),
    );
  }
}
