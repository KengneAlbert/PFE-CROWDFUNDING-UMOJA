class ValidationIAProjetModel{
 final String id;
 final String statutValidationIa;
 final String Commantaire;

 ValidationIAProjetModel({
    required this.id,
    required this.statutValidationIa,
    required this.Commantaire
  });

 factory ValidationIAProjetModel.fromMap(Map<String,dynamic> map){
  return ValidationIAProjetModel(
      id: map['id'], 
      statutValidationIa : map['statutValidationIa'], 
      Commantaire : map['Commantaire']
    );
 }

 Map<String,dynamic> toMap(){
  return{
    'id' : id,
    'statutValidationIa' : statutValidationIa,
    'Commantaire' : Commantaire
  };
 }

}