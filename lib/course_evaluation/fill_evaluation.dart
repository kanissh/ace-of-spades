import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class FillEvaluation extends StatelessWidget {
  final Map<String, dynamic> evalDocument;

  FillEvaluation({Map<String, dynamic> evalDocument}) : this.evalDocument = evalDocument;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Html(
            data:
                '<iframe src="${evalDocument['form_url']}" width=${MediaQuery.of(context).size.width} height=${MediaQuery.of(context).size.height * 0.9} frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>',
          ),
        ),
      ),
    );
  }
}
