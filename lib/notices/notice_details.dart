import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/notices/notice_object.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeDetails extends StatelessWidget {
  final NoticeObject _noticeObject;

  NoticeDetails({@required NoticeObject noticeObject}) : this._noticeObject = noticeObject;

  _launchUrl(String _url) async {
    final url = _url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Widget> buildLinksList(List<dynamic> list) {
    List<Widget> widgetList = List();
    for (var item in list) {
      widgetList.add(
        InkWell(
          onTap: () {
            _launchUrl(item['url']);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              item['display_text'],
              style: linkText18b,
            ),
          ),
        ),
      );
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _noticeObject.title,
                  style: title22b,
                ),
                SizedBox(height: 20),
                Text(
                  _noticeObject.desc,
                  style: bodyText18,
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildLinksList(_noticeObject.fileList),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
