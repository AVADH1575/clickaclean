import 'dart:async';
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/Home/ChooseProfessionProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuth {
  Future<String> signIn(BuildContext context,String email, String password);
  Future<void> resetPassword(String email);
  Future<String> signUp(BuildContext context,String email, String password);

}
class ProviderAuth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override

  Future<String> signUp(context,String email, String password) async {
    FirebaseUser user;

    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      print("===result====Firebase==="+result.user.email.toString());
      try {
        await result.user.sendEmailVerification();

        Fluttertoast.showToast(msg: "Please verify email!!");
        signIn(context,email,password);

        return user.uid;
      } catch (e) {

        print("=====errror_message====" + e.message);
      }
    }
    catch (error) {
      switch (error.code) {
        case "ERROR_OPERATION_NOT_ALLOWED":
        //errorMessage = "Anonymous accounts are not enabled";
          break;
        case "ERROR_WEAK_PASSWORD":
        //  errorMessage = "Your password is too weak";
          break;
        case "ERROR_INVALID_EMAIL":
        //  errorMessage = "Your email is invalid";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          signIn(context,email,password);
          break;
        case "ERROR_INVALID_CREDENTIAL":
        //Fluttertoast.showToast(msg: "Please verify email!");
          break;

        default:
          Fluttertoast.showToast(msg: error);
      }
    }
  }

  @override
  Future<String> signIn(BuildContext context,String email, String password) async {
    AuthResult result  = await _firebaseAuth.signInWithEmailAndPassword(email: email, password:password) ;

    if (result.user.isEmailVerified) {
      // ==================== working api ====================

      var client = new http.Client();
      try {
        var response = await client.post(
            APPURLS_PROVIDER.POST_PROVIDER_SINGUP_URL,

            headers: {"x-api-key": "boguskey" /*, ...etc*/
            },
            body: {
              'email': email,
              'password': password,
            }

        );


        if (response.statusCode == 200) {
          //enter your code

          print("Response status: ${response.statusCode}");
          print("Response body: ${response.body}");


          final jsonData = json.decode(response.body);
          if (jsonData["status"] == "true") {
            print("JSONResponse : ${jsonData["data"][0]["email"]}");
            SharedPreferences myPrefs = await SharedPreferences.getInstance();
            myPrefs.setString(STORE_PREFS_PROVIDER.PROVIDER_ID_GLOBAL,
                jsonData["data"][0]["id"].toString());
            myPrefs.setString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY,
                jsonData["data"][0]["apiKey"].toString());


            var client = new http.Client();
            try {
              var response = await client.post(
                  APPURLS_PROVIDER.POST_PROVIDER_LOGIN_URL,
                  headers: {"x-api-key": "boguskey" /*, ...etc*/
                  },
                  body: {
                    'email': email,
                    'password': password,
                    "provider_devicetoken": myPrefs.getString(STORE_PREFS.FCM_TOKEN_GLOBAL),
                    "provider_deviceType": "Android"
                  }

              );

              if (response.statusCode == 200) {
                //enter your code

                print("Response status=====login: ${response.statusCode}");
                print("Response body=====login: ${response.body}");


                final jsonData = json.decode(response.body);
                if (jsonData["status"] == true) {
                  Fluttertoast.showToast(
                      msg: "Login Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1
                  );
                  print("JSONResponse : ${jsonData["data"][0]["email"]}");
                  SharedPreferences myPrefs = await SharedPreferences
                      .getInstance();
                  myPrefs.setString(STORE_PREFS_PROVIDER.PROVIDER_ID_GLOBAL,
                      jsonData["data"][0]["id"].toString());
                  myPrefs.setString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY,
                      jsonData["data"][0]["apiKey"].toString());


                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChooseProfessionProvider()));

                }

                else {

                }
              }
            } on Exception catch (err) {
              print("Error : $err");
            }
          }

          else {
            print("========check_coming===");
            var client = new http.Client();
            try {
              SharedPreferences myPrefs = await SharedPreferences.getInstance();
              var response = await client.post(
                  APPURLS_PROVIDER.POST_PROVIDER_LOGIN_URL,
                  headers: {"x-api-key": "boguskey" /*, ...etc*/
                  },
                  body: {
                    'email': email,
                    'password': password,
                    "provider_devicetoken": myPrefs.getString(STORE_PREFS.FCM_TOKEN_GLOBAL),
                    "provider_deviceType": "Android"
                  }

              );
              print("========check_coming1===");
              if (response.statusCode == 200) {
                //enter your code
                print("========check_coming2===");
                print("Response status: ${response.statusCode}");
                print("Response body: ${response.body}");

                final jsonData = json.decode(response.body);

                if (jsonData["status"] == true) {
                  Fluttertoast.showToast(
                      msg: "Login Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1
                  );
                  print("JSONResponse : ${jsonData["data"][0]["email"]}");
                  SharedPreferences myPrefs = await SharedPreferences
                      .getInstance();
                  myPrefs.setString(STORE_PREFS_PROVIDER.PROVIDER_ID_GLOBAL,
                      jsonData["data"][0]["id"].toString());
                  myPrefs.setString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY,
                      jsonData["data"][0]["apiKey"].toString());

                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChooseProfessionProvider()));


//                  _navigateToNextScreen1(context);
                }

                else {

                }
              }
            } on Exception catch (err) {
              print("Error : $err");
            }
          }
        }
      } on Exception catch (err) {
        print("Error : $err");
      }
    }
    else {
      Fluttertoast.showToast(msg: "Please verify your mail!!");
    }

  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}