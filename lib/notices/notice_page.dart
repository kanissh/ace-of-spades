import 'package:ace_of_spades/notices/notice_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  _launchUrl(String _url) async {
    final url = _url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('notices').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {}

            if (snapshot.connectionState == ConnectionState.waiting) {}

            if (snapshot.connectionState == ConnectionState.active) {
              List<Widget> list = List();
              List fileList = snapshot.data.docs.first['files'];
              // List<Map> fileList = data['files'];

              return ListView.builder(
                itemCount: fileList.length,
                itemBuilder: (context, index) {
                  return RaisedButton(
                      child: Text(fileList[index]['display_text']),
                      onPressed: () {
                        _launchUrl(fileList[index]['url']).catchError((Object error) {
                          final snackbar = SnackBar(content: Text(error.toString()));
                          Scaffold.of(context).showSnackBar(snackbar);
                        });
                      });
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
