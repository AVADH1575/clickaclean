import 'dart:async';

import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../home_widget.dart';
abstract class BaseAuth {
  Future<String> signIn(BuildContext context,String email, String password);
  Future<void> resetPassword(String email);
  Future<String> signUp(BuildContext context ,String email, String password);

}
class Auth implements BaseAuth {
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

    FirebaseUser user;
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);


      if (result.user.isEmailVerified) {
        // ==================== working api ====================

        var client = new http.Client();
        try {
          var response = await client.post(
              APPURLS_USER.POST_USER_SINGUP_URL,

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
              myPrefs.setString(STORE_PREFS.USER_ID_GLOBAL,
                  jsonData["data"][0]["id"].toString());
              myPrefs.setString(STORE_PREFS.USER_API_KEY,
                  jsonData["data"][0]["apiKey"].toString());


              var client = new http.Client();
              try {
                var response = await client.post(
                    APPURLS_USER.POST_USER_LOGIN_URL,
                    headers: {"x-api-key": "boguskey" ,

                    },
                    body: {
                      'email': email,
                      'password': password,
                      "device_token": myPrefs.getString(STORE_PREFS.FCM_TOKEN_GLOBAL),
                      "device_type": "Android"
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
                    myPrefs.setString(STORE_PREFS.USER_API_KEY,
                        jsonData["data"][0]["apiKey"].toString());
                    myPrefs.setString(STORE_PREFS.USER_ID_GLOBAL,
                        jsonData["data"][0]["id"].toString());


                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen_Fragment()));

                  }

                  else {

                  }
                }
              } on Exception catch (err) {
                print("Error : $err");
              }
            }

            else {
              var client = new http.Client();
              try {
                SharedPreferences myPrefs = await SharedPreferences
                    .getInstance();
                var response = await client.post(
                    APPURLS_USER.POST_USER_LOGIN_URL,
                    headers: {"x-api-key": "boguskey",

                    },
                    body: {
                      'email': email,
                      'password': password,
                      "device_token": myPrefs.getString(STORE_PREFS.FCM_TOKEN_GLOBAL),
                      "device_type": "Android"
                    }

                );

                if (response.statusCode == 200) {
                  //enter your code

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
                    myPrefs.setString(STORE_PREFS.USER_API_KEY,
                        jsonData["data"][0]["apiKey"].toString());
                    myPrefs.setString(STORE_PREFS.USER_ID_GLOBAL,
                        jsonData["data"][0]["id"].toString());

                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen_Fragment()));


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
    catch (error) {
      switch (error.code) {

        case "ERROR_INVALID_EMAIL":
          Fluttertoast.showToast(msg: "Invalid Email!");
          break;
        case "ERROR_WRONG_PASSWORD":
          Fluttertoast.showToast(msg: "Wrong Password! Please Enter Valid Password.");
          break;
        case "ERROR_USER_NOT_FOUND":
          Fluttertoast.showToast(msg: "User with this email doesn't exist.");
          break;
        case "ERROR_USER_DISABLED":
          Fluttertoast.showToast(msg: "User with this email has been disabled.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          Fluttertoast.showToast(msg: "Too many requests. Try again later.");

          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          Fluttertoast.showToast(msg: "Signing in with Email and Password is not enabled.");
          break;

        default:
          Fluttertoast.showToast(msg: error);
          print("====error_message===="+error.code);
      }
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}