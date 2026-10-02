import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavProvider extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void updateIndex(int index) {
    state = index;
  }
}
