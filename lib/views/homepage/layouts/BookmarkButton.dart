import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/views/homepage/state/ButtonStateBoomark.dart';

class BookmarkButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonState = ref.watch(buttonStateBoomarkProvider);

    return Positioned(
      top: 10,
      right: 8,
      child: GestureDetector(
        onTap: () {
           ref.read(buttonStateBoomarkProvider.notifier).toggleBookmark();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: buttonState.isBookmarked ? Color(0xFF13B156).withOpacity(1) : Color(0xFF13B156).withOpacity(1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: Icon(
                buttonState.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: buttonState.isBookmarked ? Colors.white : Colors.white,
                size: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
