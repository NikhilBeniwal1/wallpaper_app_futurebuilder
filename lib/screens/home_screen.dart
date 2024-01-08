import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as httpClient;
import 'package:wallpaper_app/model_class/wallpaper_model.dart';
import 'package:wallpaper_app/screens/category_screen.dart';
import 'package:wallpaper_app/screens/wallpaper_screen.dart';

import '../model_class/color_model.dart';
class HomeScreen extends StatefulWidget {


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<WallPaperDataModel?>? wallpapersData;
  Future<WallPaperDataModel?>? mtrendigwallpapersData;
  String lastSearch = "nature";
  List<ColorModel> mColorList = [
    ColorModel(colorValue: Colors.white, colorCode: "ffffff"),
    ColorModel(colorValue: Colors.black, colorCode: "000000"),
    ColorModel(colorValue: Colors.blue, colorCode: "0000ff"),
    ColorModel(colorValue: Colors.green, colorCode: "00ff00"),
    ColorModel(colorValue: Colors.red, colorCode: "ff0000"),
    ColorModel(colorValue: Colors.purple, colorCode: "9C27B0"),
    ColorModel(colorValue: Colors.orange, colorCode: "FF9800"),
  ];

  void lastsearchf({String lastsearchh = "nature"}){
    if (lastsearchh !=null && lastsearchh.isNotEmpty){
      lastSearch = lastsearchh;
    }else {
      lastSearch = "nature";
    }

  }

  @override
  void initState() {
    wallpapersData = getSearchWallpaper();
    mtrendigwallpapersData = getTrendingWallpaper();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var _searchController = TextEditingController() ;
    String searchWal;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body:FutureBuilder<WallPaperDataModel?>(future: wallpapersData, builder: (_, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
      return Center(child: CircularProgressIndicator());
       } else{
             if(snapshot.hasError){
      return Center(child: Text("Network Error: ${snapshot.error.toString()}"));
             } else if(snapshot.hasData){
       return  snapshot.data!= null && snapshot.data!.photos!.isNotEmpty ? Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           // search box
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
               controller: _searchController,
               decoration: InputDecoration(
                   hintText: "Find wallpaper..",
                   suffixIcon: InkWell(
                     onTap: (){
                       wallpapersData = getSearchWallpaper(query: _searchController.text.toString()
                       );
                       lastsearchf(lastsearchh: _searchController.text.toString());
                        setState(() {

                       });
                     },
                     child: Icon(
                       Icons.search,
                       size: 20,
                       color: Colors.grey,
                     ),
                   ),
                   border: OutlineInputBorder()),
             ),
           ),
           SizedBox(
             height: 5,
           ),

           // best of month
           /*Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(
               "Best of month",
               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
             ),
           ),*/

           // list of best of month wallpapers

            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 160,
              child: FutureBuilder<WallPaperDataModel?>(future: wallpapersData, builder: (_, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                } else{
                  if(snapshot.hasError){
                    return Center(child: Text("Network Error: ${snapshot.error.toString()}"));
                  } else if(snapshot.hasData){
                    return  snapshot.data!= null && snapshot.data!.photos!.isNotEmpty ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.photos!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return WallPaperScreen(imageUrl: snapshot.data!.photos![index].src!.portrait!,);
                              },));
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
// decoration: ,
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.photos![index].src!.portrait!),
                                      fit: BoxFit.fill)),

//child: Image.asset(wallpaperlist[index]["img"]),
                            ),
                          );
                        }): Container();
                  }
                }
                return Container();
              },),
            ),
                    ) ,


           // coler tone text
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(
               "The color tone",
               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
             ),
           ),


           // color tone list
           Padding(
         padding: const EdgeInsets.all(8.0),
         child: SizedBox(
           // margin: EdgeInsets.symmetric(horizontal: 8),
           height: 50,
           child: ListView.builder(
               scrollDirection: Axis.horizontal,
               itemCount: mColorList.length,
               itemBuilder: (context, index) {
                 return InkWell(
                   onTap: (){


                     wallpapersData = getSearchWallpaper( query:  lastSearch  ,colorcode: mColorList[index].colorCode!/*getColorcode(snapshot!.data!.photos![index].avg_color!)*/);
                     setState(() {

                     });

                   },
                   child: Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(4),
                       color: mColorList[index].colorValue! // convertToColor(snapshot!.data!.photos![index].avg_color!),
                     ),
                     margin: EdgeInsets.only(right: 6),
                     height: 50,
                     width: 50,

                     //  child: Text("one"),
                   ),
                 );
               }),
         ),
       ),
           SizedBox(
             height: 5,
           ),

           // text Categories
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(
               "Trending Wallpapers",
               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
             ),
           ),
           SizedBox(
             height: 5,
           ),
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
        height: 160,
        child: FutureBuilder<WallPaperDataModel?>(future: mtrendigwallpapersData, builder: (_, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          } else{
            if(snapshot.hasError){
              return Center(child: Text("Network Error: ${snapshot.error.toString()}"));
            } else if(snapshot.hasData){
              return  snapshot.data!= null && snapshot.data!.photos!.isNotEmpty ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.photos!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WallPaperScreen(imageUrl: snapshot.data!.photos![index].src!.portrait!,);
                        },));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
// decoration: ,
                        width: 100,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(snapshot.data!.photos![index].src!.portrait!),
                                fit: BoxFit.fill)),

//child: Image.asset(wallpaperlist[index]["img"]),
                      ),
                    );
                  }): Container();
            }
          }
          return Container();
        },),
        ),
           // gridview wallpaper list
           /* Expanded(
              *//* height: 50,*//*
         child: GridView.builder(
             itemCount: snapshot!.data!.photos!.length,
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 childAspectRatio: 16 / 9),
             itemBuilder: (context, index) {
               return Container(
                 //margin: EdgeInsets.only(top: 6, right: 6),
                 margin: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     image: DecorationImage(
                         image:
                         NetworkImage(snapshot!.data!.photos![index].src!.landscape!),
                         fit: BoxFit.fill)),
                 child: Center(child: Text("Category.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),)),
               );
             }),
       ),*/
        )],
       ): Container();
             }
        }
        return Container();
      },) /*: Container(child: Center(child: Text("fetching..",style: TextStyle(fontSize: 30))),),*/
    );
  }

Future<WallPaperDataModel?> getSearchWallpaper({String query = "nature", String colorcode = ''}) async {
    var myApiKey = "YDrbhBEzi5NFjGOwc6kfdOeOeCIVHhTkVqvNfHZP2gNMGUpZuHKu6vw4";
var uri = Uri.parse("https://api.pexels.com/v1/search?query=$query&color=$colorcode");
var response = await httpClient.get(uri,headers: {
  "Authorization": myApiKey
});
print(response.body);

if(response.statusCode == 200) {
  Map<String,dynamic> rawData = jsonDecode(response.body);
   var data   =  WallPaperDataModel.fromjson(rawData);
return data;
     // print(wallpapersData!.);
} else{ return null;}


  }
  Future<WallPaperDataModel?> getTrendingWallpaper() async {
    var myApiKey = "YDrbhBEzi5NFjGOwc6kfdOeOeCIVHhTkVqvNfHZP2gNMGUpZuHKu6vw4";
    var uri = Uri.parse("https://api.pexels.com/v1/curated");
    var response = await httpClient.get(uri,headers: {
      "Authorization": myApiKey
    });
    print(response.body);

    if(response.statusCode == 200) {
      Map<String,dynamic> rawData = jsonDecode(response.body);
      var data   =  WallPaperDataModel.fromjson(rawData);
      return data;
      // print(wallpapersData!.);
    } else{ return null;}


  }


Color convertToColor(String colorValue) {
  String colorString = colorValue.replaceAll('#', ''); // Remove the '#' symbol
  int intValue = int.parse('0xFF$colorString'); // Convert the string to an integer
  return Color(intValue); // Return a Color object
}

String getColorcode(String colorValue){
String  colorCode = colorValue.replaceAll("#", "");

   return colorCode;

}

}
