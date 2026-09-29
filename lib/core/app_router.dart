import 'package:app_mobile/features/flights/presentation/screens/flight_screen.dart';
import 'package:app_mobile/features/login/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const FlightScreen();
        },
      ),
    ],
  );
}
