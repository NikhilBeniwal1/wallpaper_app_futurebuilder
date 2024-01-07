import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as httpClient;
import 'package:wallpaper_app/model_class/wallpaper_model.dart';
import 'package:wallpaper_app/screens/category_screen.dart';
import 'package:wallpaper_app/screens/wallpaper_screen.dart';
class HomeScreen extends StatefulWidget {


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


WallPaperDataModel? wallpapersData;
  @override
  void initState() {
    getSearchWallpaper();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: wallpapersData!=null && wallpapersData!.photos!.isNotEmpty ? Column(
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
                      getSearchWallpaper(query: _searchController.text.toString() );
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Best of month",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),

          // list of best of month wallpapers
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 160,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: wallpapersData!.photos!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WallPaperScreen(imageUrl: wallpapersData!.photos![index].src!.portrait!,);
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
                                image: NetworkImage(wallpapersData!.photos![index].src!.portrait!),
                                fit: BoxFit.fill)),

                        //child: Image.asset(wallpaperlist[index]["img"]),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          // coler tone text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "The color tone",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 5,
          ),

          // color tone list
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: convertToColor(wallpapersData!.photos![index].avg_color!),
                      ),
                      margin: EdgeInsets.only(right: 6),
                      height: 50,
                      width: 50,

                      //  child: Text("one"),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 5,
          ),

          // Categories
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 5,
          ),

          // gridview wallpaper list
          Expanded(
            child: GridView.builder(
                itemCount: wallpapersData!.photos!.length,
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
                            NetworkImage(wallpapersData!.photos![index].src!.landscape!),
                            fit: BoxFit.fill)),
                    child: Center(child: Text("Category",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),)),
                  );
                }),
          )
        ],
      ) : Container(child: Center(child: Text("fetching..",style: TextStyle(fontSize: 30))),),
    );
  }

  void getSearchWallpaper({String query = "nature",}) async {
    var myApiKey = "YDrbhBEzi5NFjGOwc6kfdOeOeCIVHhTkVqvNfHZP2gNMGUpZuHKu6vw4";
var uri = Uri.parse("https://api.pexels.com/v1/search?query=$query");
var response = await httpClient.get(uri,headers: {
  "Authorization": myApiKey
});
print(response.body);

if(response.statusCode == 200) {
  Map<String,dynamic> rawData = jsonDecode(response.body);
    wallpapersData   =  WallPaperDataModel.fromjson(rawData);
setState(() {

});
     // print(wallpapersData!.);

}
  }


Color convertToColor(String colorValue) {
  String colorString = colorValue.replaceAll('#', ''); // Remove the '#' symbol
  int intValue = int.parse('0xFF$colorString'); // Convert the string to an integer
  return Color(intValue); // Return a Color object
}

// Usage:  Color myColor = convertToColor(colorValue);

}
