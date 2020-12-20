import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class FillEvaluation extends StatefulWidget {
  final Map<String, dynamic> evalDocument;

  FillEvaluation({Map<String, dynamic> evalDocument}) : this.evalDocument = evalDocument;

  @override
  _FillEvaluationState createState() => _FillEvaluationState();
}

class _FillEvaluationState extends State<FillEvaluation> {
  /* @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: Text("Important"),
          content: Text("Message"),
          actions: <Widget>[
             FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });
  } */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Html(
            data:
                '<iframe src="${widget.evalDocument['form_url']}" width=${MediaQuery.of(context).size.width} height=${MediaQuery.of(context).size.height * 0.9} frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>',
          ),
        ),
      ),
    );
  }
}
