import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/main.dart';
import 'package:umoja/models/contribution_projet_model.dart';
import 'package:umoja/services/database_service.dart';

class ContributionProjetViewModel extends StateNotifier<ContributionProjetState> {
  final DatabaseService databaseService;

  ContributionProjetViewModel({required this.databaseService})
      : super(ContributionProjetState(contributions: []));

  Future<void> setContributionProjet(String projetId, String userId, int montant, DateTime dateContribution, String moyenPaiement) async {
    state = state.copyWith(isLoading: true);
    try {
      final contributionMap = {
        'projet_id': projetId,
        'user_id': userId,
        'montant': montant,
        'date_contribution': dateContribution.toIso8601String(),
        'moyen_paiement': moyenPaiement
      };
      await databaseService.update("Contribution", contributionMap);
      await fetchAllContributionProjets();
    } catch (e) {
      state = state.copyWith(hasError: true, error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchAllContributionProjets() async {
    state = state.copyWith(isLoading: true);
    try {
      final contributionProjets = await databaseService.fetchAll('Contribution');
      state = state.copyWith(
        contributions: contributionProjets.map((e) => e != null ? ContributionProjetModel.fromMap(e) : null).toList(),
        hasError: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(hasError: true, error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateContributionProjet(String id, ContributionProjetModel contribution) async {
    state = state.copyWith(isLoading: true);
    try {
      await databaseService.update('Contribution/$id', contribution.toMap());
      await fetchAllContributionProjets();
    } catch (e) {
      state = state.copyWith(hasError: true, error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> deleteContributionProjet(String id) async {
    state = state.copyWith(isLoading: true);
    try {
      await databaseService.delete('Contribution/$id');
      await fetchAllContributionProjets();
    } catch (e) {
      state = state.copyWith(hasError: true, error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final contributionProjetViewModelProvider =
    StateNotifierProvider<ContributionProjetViewModel, ContributionProjetState>(
  (ref) => ContributionProjetViewModel(
    databaseService: ref.watch(databaseServiceProvider),
  ),
);


class ContributionProjetState {
  final bool isLoading;
  final bool hasError;
  final String? error;
  final List<ContributionProjetModel?> contributions;

  ContributionProjetState({
    this.isLoading = false,
    this.hasError = false,
    this.error,
    required this.contributions,
  });

  ContributionProjetState copyWith({
    bool? isLoading,
    bool? hasError,
    String? error,
    List<ContributionProjetModel?>? contributions,
  }) {
    return ContributionProjetState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      error: error ?? this.error,
      contributions: contributions ?? this.contributions,
    );
  }
}
