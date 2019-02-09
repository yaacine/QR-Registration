import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../models/sheet.dart';
import '../views/listFilesPage.dart';



abstract class SheetsManager{

  static List<Sheet> sheets = [];
  static String token =
      "ya29.GlujBtbh6qLdMemIw6LaJtR-whdPHDPfEcNjXFUycOoN8vatFEKve0Ckx4nBAJsKADgrxHDCOFYCVTZF5y20KduhZiyJJYFKb-hfe1ikGDbybuqRzzyVlyZ7PlWv"; // testToken
  static bool tokenTaken = false;
  static bool isLoading = false;
  static final String defaultUrl =
      "https://b.thumbs.redditmedia.com/S6FTc5IJqEbgR3rTXD5boslU49bEYpLWOlh8-CMyjTY.png";

 static  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/spreadsheets',
      'https://www.googleapis.com/auth/drive',
      'https://www.googleapis.com/auth/drive.file',
      'https://www.googleapis.com/auth/drive.appdata'
    ],
  );

 // message to write in the participent's cell
 // recomended actual time and date
  static String checkInMsg = "Checked";
  static String sheetId=""; 

 static  List<Sheet> parseFiles(String responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);
    return parsed['files'].map<Sheet>((json) => Sheet.fromJson(json)).toList();
  }




  static Future<List<Sheet>> _fetchData() async {
    isLoading = true;
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
      isLoading = false;
      return parseFiles(response.body);
    } else {
      throw Exception('Failed to load files');
    }
  }


 static  getToken() {
   print("#########################   1");
    _googleSignIn.signIn().then((result) {
      result.authentication.then((googleKey) {
        //token = googleKey.accessToken;
        print(googleKey.accessToken);
         tokenTaken = true;
         token = googleKey.accessToken;
        print(_googleSignIn.currentUser.displayName);
        _fetchData().then((res) {
          print(">---------------------- THEN ---------------------");
           sheets = res; 
           return res;
        });
      }).catchError((err) {
        print('inner error');
      });
    }).catchError((err) {
      print('error occured');
      print(err.toString());
    });
  }


 static bool setParticipantPresent(String barcode){
     var url = "https://sheets.googleapis.com/v4/spreadsheets/"+sheetId+"/values/C"+barcode+":C"+barcode+"?valueInputOption=USER_ENTERED";
        http.put(url, headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Authorization": "Bearer "+token
        }, body: jsonEncode({"values/D": [[checkInMsg]]}) ).then((response) {
          print("Response status: ${response.statusCode}");
          print("Response body: ${response.body}");
        });
  }

}
