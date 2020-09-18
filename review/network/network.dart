import 'dart:async';
import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class NetworkDemo extends StatefulWidget {
  NetworkDemo({Key key}) : super(key: key);

  @override
  _NetworkDemoState createState() => _NetworkDemoState();
}

class _NetworkDemoState extends State<NetworkDemo> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NetWork Demo")),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
              width: 300,
              height: 300,
              child: FutureBuilder(
                  future: futureAlbum,
                  builder:
                      (BuildContext context, AsyncSnapshot<Album> snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.title);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    // Loading!!!
                    return CircularProgressIndicator();
                  })),
          RaisedButton(
              onPressed: () {
                _delete("1");
              },
              child: Text("Delete")),
          RaisedButton(
              onPressed: () {
                _create("test title");
              },
              child: Text("Create"))
        ],
      )),
    );
  }

  Future<Album> _fetch() async {
    final res = await http.get(
      'https://jsonplaceholder.typicode.com/albums/1',
      headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
    );
    print(res.body);
    if (res.statusCode == 200) {
      return Album.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<http.Response> _delete(String id) async {
    final http.Response res = await http.delete(
      'https://jsonplaceholder.typicode.com/albums/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(res.body);
    return res;
  }

  Future<http.Response> _create(String title) async {
    final http.Response res = await http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
    print(res.body);
    return res;
  }
}
