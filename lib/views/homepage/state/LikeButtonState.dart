import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeNotifier extends StateNotifier<Map<String, bool>> {
  LikeNotifier() : super({});

  void toggleLike(String projectId) {
    state = {
      ...state,
      projectId: !(state[projectId] ?? false),
    };
  }

  void firstLike(String projectId) {
    state = {
      ...state,
      projectId: (state[projectId] ?? false),
    };
  }

  void setLike(String projectId, bool isLiked) {
    state = {
      ...state,
      projectId: isLiked,
    };
  }

  bool isLiked(String projectId) {
    return state[projectId] ?? false;
  }
}

final likeProvider = StateNotifierProvider<LikeNotifier, Map<String, bool>>((ref) {
  return LikeNotifier();
});
