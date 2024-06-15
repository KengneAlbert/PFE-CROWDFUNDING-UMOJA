class NotificationModel{
 final String id;
 final String contenu;
 final String statutNotification;
 final String typeNotification;
 final DateTime dateNotification;
 final DateTime? createdAt;
 final DateTime? updateAt;

 NotificationModel({
    required this.id,
    required this.contenu,
    required this.statutNotification,
    required this.typeNotification,
    required this.dateNotification,
    this.createdAt,
    this.updateAt
  });

 factory NotificationModel.fromMap(Map<String,dynamic> map){
  return NotificationModel(
      id: map['id'], 
      contenu: map['contenu'],
      statutNotification : map['statut_notification'], 
      typeNotification : map['type_notification'],
      dateNotification : DateTime.parse(map['date_notification']),
      createdAt:  DateTime.parse(map['created_at']),
      updateAt:  DateTime.parse(map['update_at']),
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'contenu' : contenu,
    'statut_notification' : statutNotification,
    'type_notification' : typeNotification,
    'date_notification' : dateNotification,
    'create_at' : createdAt,
    'update_at' : updateAt,
  };
 }
}