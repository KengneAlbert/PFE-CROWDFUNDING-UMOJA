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
      statutNotification : map['statutNotification'], 
      typeNotification : map['typeNotification'],
      dateNotification : DateTime.parse(map['dateNotification']),
      createdAt:  DateTime.parse(map['createdAt']),
      updateAt:  DateTime.parse(map['updateAt']),
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'contenu' : contenu,
    'statutNotification' : statutNotification,
    'typeNotification' : typeNotification,
    'dateNotification' : dateNotification,
    'createAt' : createdAt,
    'updateAt' : updateAt,
  };
 }
}