import 'dart:convert';

import 'package:api_tutorials/Models/PhotosModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  List<PhotosModel> photosList = [];
  Future<List<PhotosModel>> getPhotos() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200) {
      for(Map i in data) {
        PhotosModel p = PhotosModel(title: i['title'], url: i['url']);
        photosList.add(p);
      }
      return photosList;
    }
    else {
      return photosList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context,AsyncSnapshot<List<PhotosModel>>snapshot) {
                  if(!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(color: Colors.blue,),);
                  }
                  else {
                    return ListView.builder(
                      itemCount: photosList.length,
                        itemBuilder: (context,index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                          ),
                          title: Text(snapshot.data![index].title.toString()),
                        );
                        }
                    );
                  }
                }
            ),
          )
        ],
      ),
    );
  }
}
