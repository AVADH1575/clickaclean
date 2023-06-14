import 'dart:convert';
import 'dart:io';

import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_third.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/VerifyAccount/verify_identity_second.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'IdentityCamerAccessSecond.dart';
import 'IdentityVerificationSubmitVideo.dart';

class IdentityRecordSelfieVideo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IdentityRecordSelfieVideo();
  }

}
class _IdentityRecordSelfieVideo extends State<IdentityRecordSelfieVideo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";

  File _video;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(title: Text("Identity Verification"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SafeArea(

            child:
            Align(

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[

                    Column(
                        children: <Widget>[



                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 25, 23, 0),
                                child:
                                Text("Record a selfie video",
                                  style: TextStyle(color: Color.fromRGBO(33, 32, 32, 1) ,fontSize: 21),textAlign: TextAlign.center,)
                            ),
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 8, 23, 0),
                                child:
                                Text("Let's make sure that nobody's impersonating you",
                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1) ,fontSize: 16),textAlign: TextAlign.center,)
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.fromLTRB(17, 79, 17, 0),
                            child:Container(
                              height: 189,
                              color: Color.fromRGBO(218, 218, 218, 1),
                            ),
                          ),

                        ]),

                    Container(
                        height: 60,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        margin:  EdgeInsets.fromLTRB(34, 0, 34, 20),

                        child: RaisedButton(

                          child: Container(
                            child:

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('CONTINUE',style: TextStyle(
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
                            ),

                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textColor: Colors.white,
                          color: Color.fromRGBO(241, 123, 72, 1),
                          splashColor: Color.fromRGBO(0, 0, 0, 0.16),

                          onPressed: () {
                            getVideoCamera();
                          },
                        )),


                  ],))));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IdentitySubmitVideo()),
    );
  }
  Future getVideoCamera() async{
    var imageFile = await ImagePicker.pickVideo(source: ImageSource.camera);
    setState(() {
      _video = imageFile;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IdentitySubmitVideo(imagePath:imageFile.path)),
      );

    });
  }


}