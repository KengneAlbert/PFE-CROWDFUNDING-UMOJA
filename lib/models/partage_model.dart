class PartageProjetModel{
  final String id;
  final String platforme;
  final int count;

  PartageProjetModel({
    required this.id,
    required this.platforme,
    required this.count
  });

  factory PartageProjetModel.fromMap(Map<String,dynamic> map){
    return PartageProjetModel(id: map['id'], platforme: map['platforme'], count: map['count']);
  }

  Map<String,dynamic> toMap(){
    return{
      'id': id,
      'plateforme': platforme,
      'count': count,
    };
  }
}