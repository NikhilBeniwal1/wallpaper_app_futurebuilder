import 'package:flutter/material.dart';

class WallPaperScreen extends StatefulWidget {
  String imageUrl;
   WallPaperScreen({super.key,required this.imageUrl});

  @override
  State<WallPaperScreen> createState() => _WallPaperScreenState();
}

class _WallPaperScreenState extends State<WallPaperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      width: double.infinity,
      height:  double.infinity,
      child: Image.network(widget.imageUrl,fit: BoxFit.cover,),
    ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0 /*MediaQuery.of(context).size.width * 0.2*/),
        child: Row(
         // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          SizedBox( height: 90, width: 90,
            child: Column(
              children: [
                FloatingActionButton(onPressed: (){},heroTag: "tag1",child: SizedBox(height: 50, width: 50  ,child: Container(
                  child: Icon(Icons.info_outline),)),),
                Text("info",style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
            SizedBox( height: 90, width: 90,
              child: Column(
                children: [
                  FloatingActionButton(onPressed: (){},heroTag: "tag2",child: SizedBox(height: 50, width: 50  ,child: Container(
                    child: Icon(Icons.save_alt),)),),
                  Text("Save",style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
            SizedBox( height: 90, width: 90,
              child: Column(
                children: [
                  FloatingActionButton(onPressed: (){},heroTag: "tag3",child: SizedBox(height: 50, width: 50  ,child: Container(
                    child: Icon(Icons.published_with_changes),)),),
                  Text("Apply",style: TextStyle(color: Colors.white),),
                ],
              ),
            ),

        ],),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
