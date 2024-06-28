class ContributionProjetModel {
  final String id;
  final int montant;
  final String userId;
  final String projetId;
  final DateTime dateContribution;
  final String moyenPaiement;

  ContributionProjetModel({
    required this.id,
    required this.montant,
    required this.userId,
    required this.projetId,
    required this.dateContribution,
    required this.moyenPaiement,
  });

  factory ContributionProjetModel.fromMap(Map<String, dynamic> map) {
    return ContributionProjetModel(
      id: map['id'],
      montant: map['montant'],
      userId: map['user_id'],
      projetId: map['projet_id'],
      dateContribution: DateTime.parse(map['date_contribution']),
      moyenPaiement: map['moyen_paiement'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'montant': montant,
      'user_id': userId,
      'projet_id': projetId,
      'date_contribution': dateContribution.toIso8601String(),
      'moyen_paiement': moyenPaiement,
    };
  }
}
