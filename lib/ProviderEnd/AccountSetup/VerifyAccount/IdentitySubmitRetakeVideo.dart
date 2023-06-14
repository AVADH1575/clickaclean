import 'dart:convert';
import 'dart:io';

import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/AccountSetupMain.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_third.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/VerifyAccount/verify_identity_second.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


import 'IdentintyVerificationRecordSelfieVideo.dart';
import 'IdentityVerifyTakeSelfie.dart';

class IdentitySubmitRetakeVideo extends StatefulWidget {
  String imagePath;
  IdentitySubmitRetakeVideo({this.imagePath});
  @override
  State<StatefulWidget> createState() {
    return _IdentitySubmitRetakeVideo(imagePath);
  }
}
class _IdentitySubmitRetakeVideo extends State<IdentitySubmitRetakeVideo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  File _image, _video;
  VideoPlayerController playerController;
  VoidCallback listener;
  String path;

  BuildContext context;

  _IdentitySubmitRetakeVideo(this.path);
  ProgressDialog pr;
  final _formKey = GlobalKey<FormState>();

  void initializeVideo() {
    playerController = VideoPlayerController.file(File(path))
      ..addListener(listener)
      ..setVolume(1.0)
      ..initialize()
      ..play();
  }

  @override
  void deactivate() {
    if (playerController != null) {
      playerController.setVolume(0.0);
      playerController.removeListener(listener);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (playerController != null) playerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listener = () {
    };
    initializeVideo();
    playerController.play();
  }
  @override
  Widget build(BuildContext context) {
    //============================================= loading dialoge
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    _image = File(path);
    //Optional
    pr.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return Scaffold(
        appBar: AppBar(title: Text("Identity Verification"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SafeArea(

            child:
            Align(
                alignment: Alignment.center,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[
                    Align(
                      alignment: FractionalOffset.center,
                      child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            Padding(
                              padding:  EdgeInsets.fromLTRB(52, 43, 52, 0),
                              child:Container(
                                height: 356,
                                color: Color.fromRGBO(218, 218, 218, 1),
                                child: (playerController != null
                                    ? VideoPlayer(
                                  playerController,
                                )
                                    : Container()),
                              ),
                            ),


                          ]),),

                    Column(
                      children: <Widget>[

                        Container(
                            height: 60,
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            margin:  EdgeInsets.fromLTRB(34, 0, 34, 5),

                            child: RaisedButton(

                              child: Container(
                                child: Form(key: _formKey,
                                  child:

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('SUBMIT VIDEO',style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,)),
                                      //Image.asset('assets/images/p_orange_next_icon.png',height: 20,width: 20,color: Color.fromRGBO(241, 123, 72, 1) ,),

//                           Column(
//                               children: <Widget>[
//                            FlatButton(
//                              onPressed: () {},
//                              child:Icon(Icons.play_circle_filled,color: Color.fromRGBO(241, 123, 72, 1),)
//                            )],)
                                    ],
                                  ),),

                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              textColor: Colors.white,
                              color: Color.fromRGBO(241, 123, 72, 1),
                              splashColor: Color.fromRGBO(0, 0, 0, 0.16),

                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _startUploading();
                                }
                              },
                            )),


                      ],),



                  ],))));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountSetupMAIN()),
    );
  }
  Future uploadVideo(File videoFile) async{
    setState(() {
      pr.show();
    });
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var uri = Uri.parse("http://35.178.249.246/app/api/user/SelfieVideo");
    var request = new MultipartRequest("POST", uri);

    Map<String, String> headers = { "x-api-key": myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY).toString()};

    var multipartFile = await MultipartFile.fromPath("selfieVideo", videoFile.path);
    request.files.add(multipartFile);
    request.headers.addAll(headers);

    try {
      StreamedResponse Streamresponse = await request.send();
      Streamresponse.stream.transform(utf8.decoder).listen((value) {
        print(value);
        setState(() {
          _resetState();
        });

      });
      final response = await http.Response.fromStream(Streamresponse);
      if (Streamresponse.statusCode != 200) {
        return null;
      }

      print("====image_upload==response_Data======"+Streamresponse.toString());
      _resetState();
      return Streamresponse;
    } catch (e) {
      print(e);
      return null;
    }


  }
  void _startUploading() async {
    if (_image != null ) {
      final Map<String, dynamic> response = await uploadVideo(_image);
      print("====image_upload======"+response.toString());

      if(response["status"] == true){
        _navigateToNextScreen(context);
      }

      // Check if any error occured
      if (response == null) {
        pr.hide();

        messageAllert('User details updated successfully', 'Success');
      }
    } else {
      messageAllert('Please Select a photo', 'Profile Photo');
    }
  }
  void _resetState() {
    setState(() {
      pr.hide();

      _image = null;
      _navigateToNextScreen(context);
    });
  }
  messageAllert(String msg, String ttl) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: Text(ttl),
            content: Text(msg),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Okay'),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

}