import 'dart:io';
import 'package:connectivity/connectivity.dart';

abstract class NetworkManager {

 // tests real internet connaxion
  static Future<bool>tryConnexion() async{

  var connectivityResult = await(Connectivity().checkConnectivity());
   bool inter = false;

  if( (connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi))
   { 
      try {
         await InternetAddress.lookup('google.com').then((result){
            if (result!= null && result[0].rawAddress.isNotEmpty) {
                print('connected');
                inter = true;
            }
          });

        }on SocketException catch (_) {
        print('not connected');
        inter =false;
      }
      
      
   }else{
     inter=false;
   }

 return inter;
}

}

