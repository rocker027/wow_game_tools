import 'package:flutter_riverpod/flutter_riverpod.dart';


Provider<String> helloWorldProvider = Provider((ref) {
  return 'You have pushed the button this many times:';
});

StateProvider<int> counterProvider = StateProvider((ref) {
  return 0;
});