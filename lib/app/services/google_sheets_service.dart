import 'package:gsheets/gsheets.dart';


class GoogleSheetsService {

// you will get this from json file from google cloud service

 static final _credentials = r'''
{
 "type": "Your code",
  "project_id": "Your code",
  "private_key_id": "Your code",
  "private_key": "Your code",
  "client_email": "Your code",
  "client_id": "Your code",
  "auth_uri": "Your code",
  "token_uri": "Your code",
  "auth_provider_x509_cert_url": "Your code",
  "client_x509_cert_url": "Your code",
  "universe_domain": "googleapis.com"

}''';

 static final gSheets = GSheets(_credentials);
}
