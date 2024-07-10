import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoryNotifier extends StateNotifier<Map<String, bool>> {
  FavoryNotifier() : super({});

  void toggleFavory(String projectId) {
    state = {
      ...state,
      projectId: !(state[projectId] ?? false),
    };
  }

  void firstFavory(String projectId) {
    state = {
      ...state,
      projectId: (state[projectId] ?? false),
    };
  }

  void setFavory(String projectId, bool isLiked) {
    state = {
      ...state,
      projectId: isLiked,
    };
  }

  bool isFavorised(String projectId) {
    return state[projectId] ?? false;
  }
}

final favoryProvider = StateNotifierProvider<FavoryNotifier, Map<String, bool>>((ref) {
  return FavoryNotifier();
});
