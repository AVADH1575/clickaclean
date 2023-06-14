import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';



class FirebaseHandler {
  Future<dynamic> _deepLinkBackground;
  FirebaseAuth _auth;

  FirebaseHandler(){
    _auth = FirebaseAuth.instance;
    initialiseFirebaseOnlink(_deepLinkBackground);
  }

  Future getDynamiClikData() async{
    //Returns the deep linked data
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    return data?.link;
  }

  Future getDynamiBGData(){
    //Returns the deep linked data
    return _deepLinkBackground ?? Future((){
      return false;
    });
  }

  sendEmail({email}){
    _auth.sendSignInWithEmailLink(
      email: email,
      url: "http://clickaclean.page.link",
      handleCodeInApp: true,
      androidPackageName: "com.click.clickaclean",
      iOSBundleID: 'com.click.clickaclean',
      androidInstallIfNotAvailable: true,
      androidMinimumVersion: '21',
    );
  }

  initialiseFirebaseOnlink(_deepLinkBackground){
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;

          if (deepLink != null) {
            _deepLinkBackground = Future((){
              return deepLink;
            });
          }
        },
        onError: (OnLinkErrorException e) async {
          print('onLinkError');
          print(e.message);
        }
    );
  }

}