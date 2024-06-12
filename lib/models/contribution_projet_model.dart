class ContributionProjetModel{
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
    required this.moyenPaiement
  });

 factory ContributionProjetModel.fromMap(Map<String,dynamic> map){
  return ContributionProjetModel(
      id: map['id'], 
      montant: map['montant'],
      userId : map['userId'], 
      projetId : map['projetId'],
      dateContribution : DateTime.parse(map['dateContribution']),
      moyenPaiement: map['moyenPaiement']
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'montant' : montant,
    'userId' : userId,
    'projetId' : projetId,
    'dateContribution' : dateContribution,
    'moyenPaiement' : moyenPaiement
  };
 }

}