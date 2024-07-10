import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/views/bookmark/state/ContaintBookmarkState.dart';
  // Assurez-vous que le chemin est correct

class SectionBookmarkFundingCard extends ConsumerWidget {
  const SectionBookmarkFundingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundCard = ref.watch(containtBookmarkStateProvider);

    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: fundCard,
            ),
          ),
        ),
      ],
    );
  }
}
