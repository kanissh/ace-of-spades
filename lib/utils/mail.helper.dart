import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mailer/smtp_server.dart';

const String _MAIL_CONFIG_PATH = 'assets/mail.json';
SmtpServer smtpServer;

Future<SmtpServer> getSmptServer() async {
  String json = await rootBundle.loadString(_MAIL_CONFIG_PATH);
  var mailDetails = jsonDecode(json) as Map<String, dynamic>;
}
