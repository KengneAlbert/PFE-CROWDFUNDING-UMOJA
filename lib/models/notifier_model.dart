class NotifierModel{
 final String id;
 final String userId;
 final String notificationId;
 final DateTime dateAjout;

 NotifierModel({
    required this.id,
    required this.userId,
    required this.notificationId,
    required this.dateAjout
  });

 factory NotifierModel.fromMap(Map<String,dynamic> map){
  return NotifierModel(
      id: map['id'], 
      userId : map['userId'], 
      notificationId : map['notificationId'],
      dateAjout : DateTime.parse(map['dateAjout']) 
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'userId' : userId,
    'notificationId' : notificationId,
    'dateAjout' : dateAjout
  };
 }

}