import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/views/projectunderfunding/state/ContaintSeeAllFundingState.dart';


class SectionFundingCardSearch extends ConsumerWidget{
  const SectionFundingCardSearch({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundingCardSearch = ref.watch(ContaintSeeAllFundingStateProvider);
    return  Column(
        children: fundingCardSearch,
      );
  }
}