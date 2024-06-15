import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/contribution_projet_model.dart';
import 'package:umoja/services/database_service.dart';

class ContributionProjetViewModel extends StateNotifier<List<ContributionProjetModel?>> {
 final DatabaseService databaseService;
  bool _isLoading = false;

  ContributionProjetViewModel({required this.databaseService}):super([]);

  bool get isLoading => _isLoading;

  Future<void> setContributionProjet(String projetId, String userId, int montant, DateTime dateContribution, String moyenPaiement)async{
    _isLoading = true;
    state = [...state];
    try{
        final  contributionMap = { 'projet_id' : projetId, 'user_id' : userId, 'montant' : montant, 'date_contribution' : dateContribution, 'moyen_paiement' : moyenPaiement};
        await databaseService.update("Contribution", contributionMap);
        await fetchAllContributionProjets();
    }catch (e){
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchAllContributionProjets() async {
    _isLoading = true;
    state = [...state];
    try {
      final contributionProjets = await databaseService.fetchAll('Contribution');
      state = contributionProjets.map((e) => e != null ? ContributionProjetModel.fromMap(e) : null).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }


  Future<void> updateContributionProjet(String id, ContributionProjetModel Contribution) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.update('Contribution/$id', Contribution.toMap());
      await fetchAllContributionProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteContributionProjet(String id) async {
    _isLoading = true;
    state = [...state];
    try {
      await databaseService.delete('Contribution/$id');
      await fetchAllContributionProjets();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }
}