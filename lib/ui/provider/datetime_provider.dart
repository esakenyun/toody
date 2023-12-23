import 'package:flutter_riverpod/flutter_riverpod.dart';

const defaultDateValue = 'dd/mm/yy';
const defaultTimeValue = 'hh : mm';
final dateProvider = StateProvider<String>((ref) {
  return defaultDateValue;
});

final timeProvider = StateProvider<String>((ref) {
  return defaultTimeValue;
});
