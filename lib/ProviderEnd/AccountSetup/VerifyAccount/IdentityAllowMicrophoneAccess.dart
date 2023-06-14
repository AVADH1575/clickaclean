import 'dart:io';

import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_third.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/VerifyAccount/verify_identity_second.dart';
import 'package:click_a_clean/UserEnd/camera_screen.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'IdentityCamerAccessSecond.dart';
import 'IdentityVerificationSubmitVideo.dart';

class IdentityAllowMicrophoneAccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IdentityAllowMicrophoneAccess();
  }
}
class _IdentityAllowMicrophoneAccess extends State<IdentityAllowMicrophoneAccess> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  File _video;
  File _image;
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
                                padding:  EdgeInsets.fromLTRB(23, 30, 23, 0),
                                child:
                                Text("Allow microphone access",
                                  style: TextStyle(color: Color.fromRGBO(33, 32, 32, 1) ,fontSize: 21),textAlign: TextAlign.center,)
                            ),
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 9, 23, 0),
                                child:
                                Text("Enable your microphone to take video",
                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1) ,fontSize: 16),textAlign: TextAlign.center,)
                            ),
                          ),
                          Padding(
                              padding:  EdgeInsets.fromLTRB(33, 50, 33, 0),
                              child:Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  // checkColor: Color.fromRGBO(241, 123, 72, 1) ,
                                  SvgPicture.asset("assets/images/tap-allow-icon.svg",height: 19,width: 25,),
                                  Padding(
                                    padding:  EdgeInsets.fromLTRB(5, 5, 23, 0),
                                    child:
                                    RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: 'Tap',
                                        style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 11 ), /*defining default style is optional */
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: ' Allow', style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromRGBO(0, 0, 0, 1) ,fontSize: 11)),

                                          TextSpan(
                                              text: ' on the popup that will appear on the\n',
                                              style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) , fontSize: 11)),
                                          TextSpan(
                                              text: 'next screen',
                                              style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) , fontSize: 11)),
                                        ],
                                      ),
                                    ),


                                    //Text("Tap Allow on the popup that will appear on the\nnext screen",
                                    // style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 11),textAlign: TextAlign.justify,)
                                  ),
                                ],
                              )
                          )
                          ,

                          Padding(
                            padding:  EdgeInsets.fromLTRB(33, 18, 33, 0),
                            child:SvgPicture.asset("assets/images/allow-camera-access.svg",),
                          ),

                          Padding(
                              padding:  EdgeInsets.fromLTRB(29, 18, 29, 0),
                              child:
                              Text("If you deny microphone access you won't be able to take video and complete the verification process",
                                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1) ,fontSize: 11),textAlign: TextAlign.justify,)
                          ),
                        ]),

                    Container(
                        height: 60,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        margin:  EdgeInsets.fromLTRB(34, 0, 34, 90),

                        child: RaisedButton(

                          child: Container(
                            child:

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('ENABLE MICROPHONE',style: TextStyle(
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
      MaterialPageRoute(builder: (context) => CameraScreen()),
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