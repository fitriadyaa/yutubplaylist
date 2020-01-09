import 'package:flutter/material.dart';
import 'package:yutubplaylist/playlist.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.playlist_play),
                title: Text(
                  'Flutter',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Playlist(
                        url: 'https://flutterqu.herokuapp.com/',
                        title: 'flutter',
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
