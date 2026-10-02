import 'package:app_mobile/core/provider/app_loader_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppLoader extends ConsumerWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFrame = ref.watch(loaderProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/loading$currentFrame.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
