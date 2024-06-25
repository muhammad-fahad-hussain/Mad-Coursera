import 'dart:convert';
import 'package:api_tutorials/Models/CommentModel.dart';
import 'package:api_tutorials/Models/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CommentModel> postList = [];
  Future<List<CommentModel>> getPostApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200) {
      for(Map i in data) {
        postList.add(CommentModel.fromJson(i));
      }
      return postList;
    }
    else {
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Data'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context,snapshot) {
                  if(!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(color: Colors.green,),);
                  }
                  else {
                    return ListView.builder(
                      itemCount: postList.length,
                        itemBuilder: (context,index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.green,
                            child: ListTile(
                              title: Text(postList[index].email.toString()),
                              subtitle: Text(postList[index].name.toString()),
                            ),
                          ),
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
