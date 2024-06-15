class MediaProjetModel{
 final String id;
 final String typeMedia;
 final List<String> urlMedia;

 MediaProjetModel({
    required this.id,
    required this.typeMedia,
    required this.urlMedia
  });

 factory MediaProjetModel.fromMap(Map<String,dynamic> map){
  return MediaProjetModel(
      id: map['id'], 
      typeMedia : map['type_media'], 
      urlMedia : map['url_media']
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'type_media' : typeMedia,
    'url_media' : urlMedia
  };
 }

}