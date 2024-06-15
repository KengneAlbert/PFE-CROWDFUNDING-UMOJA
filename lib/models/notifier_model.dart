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
      userId : map['user_id'], 
      notificationId : map['notification_id'],
      dateAjout : DateTime.parse(map['date_ajout']) 
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'user_id' : userId,
    'notification_id' : notificationId,
    'date_ajout' : dateAjout
  };
 }

}