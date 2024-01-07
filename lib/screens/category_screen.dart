import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
          Text("no of Walpapers available",style: TextStyle(color: Colors.grey),),
          Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.4 / 2),
            itemBuilder: (context, index) {
            return Container(
              //margin: EdgeInsets.only(top: 6, right: 6),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image:
                      NetworkImage("https://images.pexels.com/photos/3225517/pexels-photo-3225517.jpeg"),
                      fit: BoxFit.fill)),
             // child: Text("sample"),
            );
          },))

        ],),
      ),
    );
  }
}

