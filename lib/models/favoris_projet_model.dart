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
      userId : map['user_id'], 
      projetId : map['projet_id'],
      dateAjout : DateTime.parse(map['date_ajout']) 
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'user_id' : userId,
    'projet_id' : projetId,
    'date_ajout' : dateAjout
  };
 }

}