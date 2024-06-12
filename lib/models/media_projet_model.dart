class MediaProjetModel{
 final String id;
 final String typeMedia;
 final String urlMedia;

 MediaProjetModel({
    required this.id,
    required this.typeMedia,
    required this.urlMedia
  });

 factory MediaProjetModel.fromMap(Map<String,dynamic> map){
  return MediaProjetModel(
      id: map['id'], 
      typeMedia : map['typeMedia'], 
      urlMedia : map['urlMedia']
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'typeMedia' : typeMedia,
    'urlMedia' : urlMedia
  };
 }

}