import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../models/sheet.dart';

import '../views/';



List<Sheet> sheets = [];
  String token =
      "ya29.GlujBtbh6qLdMemIw6LaJtR-whdPHDPfEcNjXFUycOoN8vatFEKve0Ckx4nBAJsKADgrxHDCOFYCVTZF5y20KduhZiyJJYFKb-hfe1ikGDbybuqRzzyVlyZ7PlWv"; // testToken
  bool tokenTaken = false;
  bool isLoading = false;
  final String defaultUrl =
      "https://b.thumbs.redditmedia.com/S6FTc5IJqEbgR3rTXD5boslU49bEYpLWOlh8-CMyjTY.png";

  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/spreadsheets',
      'https://www.googleapis.com/auth/drive',
      'https://www.googleapis.com/auth/drive.file',
    ],
  );


   List<Sheet> parseFiles(String responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);

    return parsed['files'].map<Sheet>((json) => Sheet.fromJson(json)).toList();
  }




  Future<List<Sheet>> _fetchData() async {
    
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
        "https://www.googleapis.com/drive/v3/files?corpora=user&orderBy=modifiedTime desc&q=mimeType = \"application/vnd.google-apps.spreadsheet\"",
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          "Authorization": "Bearer " + token
        });
    if (response.statusCode == 200) {
      print(">---------------------- RESPONSE ---------------------");
      print(response.body);
      print(">---------------------- END RESPONSE ---------------------");
     
      return parseFiles(response.body);
    } else {
      throw Exception('Failed to load files');
    }
  }


 getToken() {
    _googleSignIn.signIn().then((result) {
      result.authentication.then((googleKey) {
        //token = googleKey.accessToken;
        print(googleKey.accessToken);
        setState(() => tokenTaken = true);
        setState(() {
          token = googleKey.accessToken;
        });
        print(_googleSignIn.currentUser.displayName);
        _fetchData().then((res) {
          print(">---------------------- THEN ---------------------");
          setState(() {
            sheets = res;
          });
        });
      }).catchError((err) {
        print('inner error');
      });
    }).catchError((err) {
      print('error occured');
    });
  }
