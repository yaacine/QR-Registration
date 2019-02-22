import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../models/sheet.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';

abstract class SheetsManager{

  static List<Sheet> sheets = [];
  static String token =
      "ya29.GlujBtbh6qLdMemIw6LaJtR-whdPHDPfEcNjXFUycOoN8vatFEKve0Ckx4nBAJsKADgrxHDCOFYCVTZF5y20KduhZiyJJYFKb-hfe1ikGDbybuqRzzyVlyZ7PlWv"; // testToken
  static bool tokenTaken = false;
  static bool isLoading = false;
  static final String defaultUrl =
      "https://b.thumbs.redditmedia.com/S6FTc5IJqEbgR3rTXD5boslU49bEYpLWOlh8-CMyjTY.png";

  
 static  GoogleSignIn googleSignIn = new GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/spreadsheets',
      'https://www.googleapis.com/auth/drive',
      'https://www.googleapis.com/auth/drive.file',
      'https://www.googleapis.com/auth/drive.appdata'
    ],
  );
  

 // message to write in the participent's cell
 // recomended actual time and date
  
  static String sheetId=""; 

 static Future<List<Sheet>> parseFiles(String responseBody)  async{
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
     
      var resp = await parseFiles(response.body);
      isLoading = false;
      return resp;
    } else {
      throw Exception('Failed to load files');
    }
  }


 static Future<bool> getToken() async {
    
    await googleSignIn.signIn().then((result) async{
      await result.authentication.then((googleKey) async {
        //token = googleKey.accessToken;
        
         tokenTaken = true;
         token = googleKey.accessToken;
       
        await  _fetchData().then((res) {
          
           sheets = res; 
           return res;
        });
      }).catchError((err) {
        throw(err);
      });
    }).catchError((err) {
     throw(err);
    });
  }

 static void testVoid() async{
    getToken();
 }

 static Future<bool> setParticipantPresent(String barcode) async{
    var result2=false;
    var dateNow = DateTime.now();
     String checkInMsg = "Checked at " +dateNow.toString();
     var url = "https://sheets.googleapis.com/v4/spreadsheets/"+sheetId+"/values/C"+barcode+":C"+barcode+"?valueInputOption=USER_ENTERED";
       
       try{
          await http.put(
            url, 
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              "Authorization": "Bearer "+token
            },
            body:await jsonEncode({"values": [[checkInMsg]]}) ).then((response) {
              if(response.statusCode==200){
                result2= true;
              }
              else{
                result2= false; 
              }
              
            }
            );
       } on Exception catch(e){
         result2= false;
       }
       return result2;
       
  }

   
   

static Future<String> scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      
      if(barcode!= null){
        bool s = await SheetsManager.setParticipantPresent(barcode);
        if(s==true){
          return '0'; // success
        }
        else{
          return '3';  // connexion error
        }
        

      }
     
    } on FormatException{
     
    }  on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        return '1'; // camera permission error
      } else {
        return '2'; // general erroe
      }
    }
    catch (e) {
       return '2'; // general error
    }
  }
   

}// class end
