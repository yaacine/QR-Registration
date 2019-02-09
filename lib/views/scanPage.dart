import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import '../controllers/participentsSheetController.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {

  String barcode ="";
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
    }
  
  @override
  Widget build(BuildContext context) {


    final scanAppBar =AppBar(
          title: new Text('Scan'),
          elevation: 1.1,
          backgroundColor: Color.fromRGBO(78, 76, 106, 1.0), // best color until now
    );


    final scanBody = Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                
                SizedBox(
                  width: 150.0,
                  height: 150.0,
                 child: FloatingActionButton(
                    elevation: 8.0,
                    backgroundColor: Color.fromRGBO(243, 177, 11, 0.8),
                    onPressed: scan,
                    child:
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child:  Column(
                      children: <Widget>[
                        Icon(Icons.photo_camera    , size: 75.0,),
                        SizedBox(height: 1.0,),
                        Text('START SCAN' , style: TextStyle(color: Colors.white , fontSize: 20.0),)

                      ],
                    ) ,
                    )
                   ),                  
                )
             
             
            ],
          ),
        );
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: scanAppBar,
        body: scanBody,
        
        );
  }


Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      if(barcode!= null){
         setState(() => this.barcode = barcode);
         SheetsManager.setParticipantPresent(barcode);
      }
     
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    }  on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!'; 
        });
        
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    }
    catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

}