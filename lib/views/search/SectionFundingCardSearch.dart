import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/views/search/state/FundingCardSearchState.dart';


class SectionFundingCardSearch extends ConsumerWidget{
 
  const SectionFundingCardSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundingCardSearch = ref.watch(FundingCardSearchStateProvider);
    return  Column(
        children: fundingCardSearch,
      );
  }
}