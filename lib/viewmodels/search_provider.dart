import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the search query
final searchQueryProvider = StateProvider<String>((ref) => '');
