class VideoImpact{
 final String miniature;
 final String video;


 VideoImpact({
    required this.miniature,
    required this.video,
  });



  factory VideoImpact.fromMap(Map<String,dynamic> map){
  return VideoImpact(
      miniature: map['miniature'], 
      video : map['video'], 
    );
  }

 Map<String,dynamic> toMap(){
    return{
      'miniature' : miniature,
      'video' : video,
  };

}  

}