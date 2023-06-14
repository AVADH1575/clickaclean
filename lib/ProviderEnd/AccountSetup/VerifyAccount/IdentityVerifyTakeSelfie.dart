import 'dart:io';

import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_third.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/VerifyAccount/CameraBackClick.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/VerifyAccount/verify_identity_second.dart';
import 'package:click_a_clean/UserEnd/camera_screen.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'IdentitySelfieConfirmation.dart';

class IdentyVerifyTakeSelfie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IdentyVerifyTakeSelfie();
  }
}
class _IdentyVerifyTakeSelfie extends State<IdentyVerifyTakeSelfie> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
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
                                Text("Take a selfie",
                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1) ,fontSize: 21),textAlign: TextAlign.center,)
                            ),
                          ),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 9, 23, 0),
                                child:
                                Text("We will compare the photo in your document with your selfie",
                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1) ,fontSize: 16),textAlign: TextAlign.center,)
                            ),
                          ),
                          Padding(
                              padding:  EdgeInsets.fromLTRB(23, 31, 0, 0),
                              child:Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  // checkColor: Color.fromRGBO(241, 123, 72, 1) ,
                                  Icon(Icons.check,color: Color.fromRGBO(241, 123, 72, 1) ,),
                                  Padding(
                                      padding:  EdgeInsets.fromLTRB(5, 5, 23, 0),
                                      child:
                                      Text("Please, keep a straight face",
                                        style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 14),textAlign: TextAlign.justify,)
                                  ),
                                ],
                              )
                          )
                          ,

                          Padding(
                              padding:  EdgeInsets.fromLTRB(23, 19, 0, 0),
                              child:Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  // checkColor: Color.fromRGBO(241, 123, 72, 1) ,
                                  Icon(Icons.check,color: Color.fromRGBO(241, 123, 72, 1) ,),
                                  Padding(
                                      padding:  EdgeInsets.fromLTRB(5, 5, 23, 0),
                                      child:
                                      Text("Wearing glasses? Make sure we can\nclearly see your eyes",
                                        style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 14),textAlign: TextAlign.justify,)
                                  ),
                                ],
                              )
                          ),

                        ]),

                    Container(
                        height: 60,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        margin:  EdgeInsets.fromLTRB(34, 0, 34, 27),

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
                            getCameraImage();
                          },
                        )),


                  ],))));
  }
  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IdentitySelfieConfirmation(imagePath:image.path,check_front: true,)),
      );
    });
  }

}