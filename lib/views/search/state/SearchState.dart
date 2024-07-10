import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchState extends StateNotifier<String> {
  SearchState() : super('All');

  void selectButton(String buttonText) {
    state = buttonText;
  }
}

final SearchStateProvider = StateNotifierProvider<SearchState, String>((ref) {
  return SearchState();
});
