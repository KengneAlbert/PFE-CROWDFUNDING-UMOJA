class DocumentProjetModel{
 final String id;
 final String typeDocument;
 final String urlDocument;

 DocumentProjetModel({
    required this.id,
    required this.typeDocument,
    required this.urlDocument
  });

 factory DocumentProjetModel.fromMap(Map<String,dynamic> map){
  return DocumentProjetModel(
      id: map['id'], 
      typeDocument : map['typeDocument'], 
      urlDocument : map['urlDocument']
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'typeDocument' : typeDocument,
    'urlDocument' : urlDocument
  };
 }

}