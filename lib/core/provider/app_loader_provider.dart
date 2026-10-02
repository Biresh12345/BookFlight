import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final loaderProvider = NotifierProvider<LoaderNotifier, int>(
  LoaderNotifier.new,
);

class LoaderNotifier extends Notifier<int> {
  Timer? _timer;

  @override
  int build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    _timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      state = state >= 7 ? 1 : state + 1;
    });

    return 1;
  }
}
