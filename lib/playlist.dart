import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:yutubplaylist/mydrawer.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Playlist extends StatefulWidget {
  final String url;
  final String title;

  Playlist({this.url, this.title});

  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  Future<List> getData() async {
    final response = await http.get(widget.url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListVideo(
                  list: snapshot.data,
                )
              : CircularProgressIndicator();
        },
      ),
    );
  }
}

class ListVideo extends StatelessWidget {
  final List list;
  ListVideo({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  SingleChildScrollView(
                    child: FlutterYoutube.playYoutubeVideoByUrl(
                        apiKey: "AIzaSyBXwSqF7XIukm14jWzxk62W0J-LSDSZX6I",
                        videoUrl: list[i]['snippet']['contentDetails']
                            ['videoId'],
                        autoPlay: true, //default falase
                        fullScreen: true //default false
                        ),
                  );
                },
                child: Container(
                  height: 210,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(list[i]['snippet']['thumbnails']
                              ['medium']['url']),
                          fit: BoxFit.cover)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                list[i]['snippet']['title'],
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Divider()
            ],
          ),
        );
      },
    );
  }
}

// class VideoPlay extends StatelessWidget {
//   final String url;

//   VideoPlay({this.url});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: WebviewScaffold(
//         url: url,
//       ),
//     );
//   }
// }
