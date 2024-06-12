class VoteProjetModel{
 final String id;
 final String userId;
 final String projetId;
 final DateTime dateVote;

 VoteProjetModel({
    required this.id,
    required this.userId,
    required this.projetId,
    required this.dateVote
  });

 factory VoteProjetModel.fromMap(Map<String,dynamic> map){
  return VoteProjetModel(
      id: map['id'], 
      userId : map['userId'], 
      projetId : map['projetId'],
      dateVote : DateTime.parse(map['dateVote']) 
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'userId' : userId,
    'projetId' : projetId,
    'dateVote' : dateVote
  };
 }

}