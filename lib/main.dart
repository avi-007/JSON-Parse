import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();

  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('JSON Parse'),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
        ),
        body: new Center(
          child: new ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context, int position) {
              if (position.isOdd) return new Divider();
              final index = position ~/ 2;
              return new ListTile(
                subtitle: new Text("${_data[index]['body']}",
                    style: new TextStyle(
                        color: Colors.grey,
                        fontSize: 13.4,
                        fontStyle: FontStyle.italic)),
                leading: new CircleAvatar(
                  backgroundColor: Colors.green,
                  child: new Text(
                    "${_data[index]['body'][0].toString().toUpperCase()}",
                    style: new TextStyle(
                        fontSize: 19.4, color: Colors.orangeAccent),
                  ),
                ),
                title: new Text(
                  "${_data[index]['title']}",
                  style: new TextStyle(fontSize: 18.9),
                ),
                onTap: () {
                  _showOnTapMessage(context, "${_data[index]['title']}");
                },
              );
            },
          ),
        ),
      )));
}

Future<List> getJson() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: new Text('JSON Parse'),
    content: new Text(message),
    actions: <Widget>[
      new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('OK'))
    ],
  );
  showDialog(context: context, child: alert);
}
