import 'dart:convert';

import 'package:api_tutorials/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200) {
      for(Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Expanded(
          child: FutureBuilder(
              future: getUsers(),
              builder: (context,AsyncSnapshot<List<UserModel>> snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.green,),);
                }
                else {
                  return ListView.builder(
                    itemCount: userList.length,
                      itemBuilder: (context,index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name: '+ snapshot.data![index].name.toString()),
                                  Text('City: ' + snapshot.data![index].address!.city.toString()),
                                  Text('Phone No: '+ snapshot.data![index].phone.toString()),
                                  Text('Company Name: '+ snapshot.data![index].company!.name.toString()),
                                  Reused(website: snapshot.data![index].website.toString())
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  );
                }
              }
          )
      ),
    );
  }
}
class Reused extends StatelessWidget {
  String website;
  Reused({super.key,required this.website});

  @override
  Widget build(BuildContext context) {
    return Text('Website URL: '+ website);
  }
}

