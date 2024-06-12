class FavorisProjetModel{
 final String id;
 final String userId;
 final String projetId;
 final DateTime dateAjout;

 FavorisProjetModel({
    required this.id,
    required this.userId,
    required this.projetId,
    required this.dateAjout
  });

 factory FavorisProjetModel.fromMap(Map<String,dynamic> map){
  return FavorisProjetModel(
      id: map['id'], 
      userId : map['userId'], 
      projetId : map['projetId'],
      dateAjout : DateTime.parse(map['dateAjout']) 
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'userId' : userId,
    'projetId' : projetId,
    'dateAjout' : dateAjout
  };
 }

}