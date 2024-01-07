import 'package:flutter/cupertino.dart';

class WallPaperDataModel{
String? next_page;
int? page;
int? per_page;
List<photosModel>? photos;
int? total_results;

WallPaperDataModel({
        required this.next_page,
        required this.page,
        required this.per_page,
        required this.photos,
        required this.total_results
});

factory WallPaperDataModel.fromjson(Map<String,dynamic> json){
  List<photosModel>? allPhotos = [];
for(Map<String, dynamic> eachPhoto in json['photos']){

  allPhotos.add(photosModel.fromjson(eachPhoto));
}


  return WallPaperDataModel(
    next_page: json['next_page'],
      page: json['page'],
      per_page: json['per_page'],
      photos: allPhotos,
      total_results: json['total_results'],
  );

}

}


class photosModel{
String? alt;
String? avg_color;
int?    height;
int? id;
bool? liked;
String? photographer;
String? photographer_url;
int? photographer_id;
String? url;
int? width;
SrcModel? src;

photosModel(
      {
        required this.alt,
        required this.avg_color,
        required this.height,
        required this.id,
        required this.liked,
        required this.photographer,
        required this.photographer_url,
        required this.photographer_id,
        required this.url,
        required this.width,
        required this.src});

factory photosModel.fromjson(Map<String,dynamic> json){
  return photosModel(
    alt: json['alt'],
    avg_color: json['avg_color'],
    height: json['height'],
    id: json['id'],
    liked: json['liked'],
    photographer: json['photographer'],
    photographer_url: json['photographer_url'],
    photographer_id: json['photographer_id'],
    url: json['url'],
    width: json['width'],
    src: SrcModel.fromjson(json['src'])
  );
}




}

class SrcModel{
 String? landscape;
 String? large;
 String? large2x;
 String? medium;
 String? original;
 String? portrait;
 String? small;
 String? tiny;

 SrcModel(
      {required this.landscape,
        required this.large,
        required  this.large2x,
        required  this.medium,
        required  this.original,
        required  this.portrait,
        required this.small,
        required this.tiny});


 factory SrcModel.fromjson(Map<String,dynamic> json){
   return SrcModel(
       landscape: json['landscape'],
       large: json['large'],
       large2x: json['large2x'],
       medium: json['medium'],
       original: json['original'],
       portrait: json['portrait'],
       small: json['small'],
       tiny: json['tiny'],
   );
 }

}