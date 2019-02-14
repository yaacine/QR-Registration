import 'dart:io';
import 'dart:async';

abstract class NetworkManager {

 // tests real internet connaxion
  bool tryConnexion(){
      try {
        InternetAddress.lookup('google.com').then((result){
           if (result!= null && result[0].rawAddress.isNotEmpty) {
              print('connected');
              return true;
           }
        });

      }on SocketException catch (_) {
      print('not connected');
      return false;
    }
     
 
}

}

