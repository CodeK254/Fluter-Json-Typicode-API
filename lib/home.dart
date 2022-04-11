// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class Todo{
  int uid;
  String title;
  bool completed;

  Todo({required this.uid,required this.title,required this.completed});

  Todo.fromJson(Map json):
    uid = json['id'],
    title = json['title'],
    completed = json['completed'];
}

class _HomePageState extends State<HomePage> {
  bool lightMode = true;
  List data = [];


  getTypicode() async {
    Response response = await get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    List data = jsonDecode(response.body);
    //print(response.body);

     var d_data=data.map((article)=>Todo.fromJson(article)).toList();
     return d_data;
  }

  getData() async {
    data = await getTypicode();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
  
    Color bg_color = !lightMode ? Colors.black : Colors.white;
    Color txt_color = !lightMode ? Colors.white : Colors.black;
    Color tb_color = !lightMode ? Colors.black : Colors.teal;
    Color fab_color = !lightMode ? Colors.red : Colors.teal;

    return Scaffold(
      backgroundColor: bg_color,
      appBar: AppBar(
        backgroundColor: tb_color,
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        title: Text(
          'USA right now',
          style: TextStyle(
            fontFamily: 'MeriendaOne',
            fontSize: 23,
            color: Colors.white,
          ),
        ),
        leading: GestureDetector(
          child: Icon(Icons.menu),
        ),
        actions: [
          GestureDetector(onTap: (){} ,child: Icon(Icons.wifi)),
          SizedBox(width: 20,),
          lightMode ?
          GestureDetector(onTap: (){setState(() {
            lightMode = false;
          });} ,child: Icon(Icons.dark_mode_sharp))
          :
          GestureDetector(onTap: (){setState(() {
            lightMode = true;
          });} ,child: Icon(Icons.light_mode_sharp)),
          SizedBox(width: 20,),
          GestureDetector(onTap: (){} ,child: Icon(Icons.search)),
          SizedBox(width: 20,),

        ],
      ),
      body: ListView(
        children: data.map((item) => Card( 
        color: bg_color,
        child:ListTile(
          textColor: Colors.black,
          onTap: (){},
          title:Text(
            item.title,
            style: TextStyle(
              fontFamily: 'Rancho',
              fontSize: 18,
              color: txt_color,
            ),
          ),
          leading: Text(item.uid.toString(),
          style: TextStyle(
              fontFamily: 'Rancho',
              fontSize: 12,
              color: txt_color,
            ),
          ),
          trailing: 
          item.completed ? 
          CircleAvatar(
            radius: 5,
            backgroundColor: Colors.green,
          )
          :
          CircleAvatar(
            radius: 5,
            backgroundColor: Colors.red,
          ),
        ),
        )).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: fab_color,
        onPressed: (){
          getData();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}