import 'package:flutter/material.dart';
import './globalCompounents.dart';
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
    
     void showCheckedToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Checked successfully'),
        action: SnackBarAction(
            label: 'Ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void showErrorToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Error! try again'),
        action: SnackBarAction(
            label: 'Ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void showConnexionErrorToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Connexion Error!'),
        action: SnackBarAction(
            label: 'Ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void showPermissionsErrorToast(BuildContext context) {
   
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Error ! make sure you grant camera permissions '),
        action: SnackBarAction(
            label: 'Ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }



// compounents
  


Center scanBody (BuildContext context) => Center(
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
                    onPressed:()async{
                      
                      // keep sacnning until the user clicks on back button
                      String result = await SheetsManager.scan();   
                      switch (result) {
                        case '0' : 
                            showCheckedToast(context);
                          break;
                        case '1' : 
                            showPermissionsErrorToast(context);
                          break;
                        case '2' : 
                            showErrorToast(context);
                          break;
                        
                         case '3' : 
                            showConnexionErrorToast(context);
                          break;
                    
                        default:
                      }                   
                    } ,
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
        appBar: generalAppbar(context,'Scan'),
        body: Builder(
          builder: (context)=>  scanBody(context),
        ),
         
        
        );
  }

}