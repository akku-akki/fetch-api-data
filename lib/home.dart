import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List userData;
  bool isLoding=true;
  final String url = "https://randomuser.me/api/?results=50";
  Future getData()async{
    var response = await http.get(
      Uri.encodeFull(url),headers: {"Accept":"application/json"});
      
      List data = jsonDecode(response.body)['results'];
     
      setState(() {
         print(data);
       userData  = data;
       isLoding = false;
      });

      
  }
  @override
      void initState() { 
        super.initState();
        this.getData();
      }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Users'),
      ),
      body: Container(
        child: Center(
          child: isLoding?
          CircularProgressIndicator():
          ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context,index){
              return Card(
                child: Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Image(
                      width: 75.0,
                      height: 75.0
                      ,fit: BoxFit.contain,
                      image: NetworkImage(userData[index]['picture']["thumbnail"]),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                           userData[index]['name']['first']+
                           " "+
                           userData[index]['name']['last'],
                           style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                           
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Icon(Icons.phone),
                            SizedBox(
                              width: 15,
                              height: 15,
                            ),
                            Text("Phone:${userData[index]['phone']}"),
                          ],
                        ),
                        Text(userData[index]['phone']),
                      ],
                    ),
                  )
                ],),
              );
            },
          ),
        ),),
    );
  }
}