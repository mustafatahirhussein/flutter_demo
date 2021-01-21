import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.amber),
    home: JsonData(),
  ));
}

class JsonData extends StatefulWidget {
  @override
  _JsonDataState createState() => _JsonDataState();
}

class _JsonDataState extends State<JsonData> {

  List users = [];
  Map data;

  Future getJsonData() async
  {
    http.Response response = await http.get("https://reqres.in/api/users?delay=3");
    data = json.decode(response.body);
    setState(() {
      users = data['data'];
    });
    print(users.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJsonData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http Response"),
      ),
        body: Center(
      child: Container(
        child: ListView.builder(
          itemCount: users.length,
            itemBuilder: (BuildContext context,int index) {
              return Card(
                child: Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          child: Image.network(users[index]['avatar'],fit: BoxFit.fill),
                        ),
                      ),
                      Text('${users[index]['first_name']} ${users[index]['last_name']} \n ${users[index]['email']}')
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    ));
  }
}
