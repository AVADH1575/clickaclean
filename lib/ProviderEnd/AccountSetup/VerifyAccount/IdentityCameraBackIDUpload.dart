import 'dart:convert';
import 'dart:io';


import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/camera_screen.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CameraBackClick.dart';
import 'IdentintyVerificationRecordSelfieVideo.dart';
import 'IdentityVerifyTakeSelfie.dart';

class IdentityCameraBackIDUpload extends StatefulWidget {
  String imagePath;
  var check_front;
  var check_back;

IdentityCameraBackIDUpload({this.imagePath,this.check_front,this.check_back});
  @override
  State<StatefulWidget> createState() {
    return _IdentityCameraBackIDUpload();
  }
}
class _IdentityCameraBackIDUpload extends State<IdentityCameraBackIDUpload> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  var _firstPress = true ;
  File _image, _imageback;
  ProgressDialog pr;
  final _formKey = GlobalKey<FormState>();
  String ButtonChangeString_forBack ;

  @override
  Widget build(BuildContext context) {

    //============================================= loading dialoge
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    _image = File(widget.imagePath);
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
        appBar: AppBar(title: Text("National ID"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

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
                              padding:  EdgeInsets.fromLTRB(17, 117, 17, 0),
                              child:Container(
                                  height: 189,
                                  width: 220,
                                  color: Color.fromRGBO(218, 218, 218, 1),
                                  child: Image.file(File(widget.imagePath), fit: BoxFit.cover)
                              ),
                            ),

                            Padding(
                                padding:  EdgeInsets.fromLTRB(29, 51, 29, 0),
                                child:
                                Text("Make sure your card details are clear to read, with no blur or glare",
                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 14),textAlign: TextAlign.center,)
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
                                child:
                                Form(key: _formKey,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("MY CARD IS READABLE",style: TextStyle(
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

                              }, )),



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
                                    Text('TAKE A NEW PICTURE',style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(241, 123, 72, 1))),
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
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Color.fromRGBO(241, 123, 72, 1))
                              ),
                              textColor: Color.fromRGBO(241, 123, 72, 1),
                              color: Colors.white,


                              onPressed: () {
                                getCameraImage();
                              },
                            ))

                      ],),



                  ],))));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IdentyVerifyTakeSelfie()),
    );
  }

  //================================= API Area to upload image ==========================================

  Uri apiUrlBack = Uri.parse(
      'http://35.178.249.246/app/api/user/NationalIdBack');

  Future<Map<String, dynamic>> _uploadImage(File image) async {
    setState(() {
      pr.show();
    });
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    final mimeTypeData =
    lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

    Map<String, String> headers = { "x-api-key": myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY).toString()};
    // Initialize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', apiUrlBack);

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath(
        'idBack', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.files.add(file);
    imageUploadRequest.headers.addAll(headers);

    imageUploadRequest.fields['service_id'] = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_SERVICE_TYPE).toString()
    ;

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("====image_upload==response_Data======"+responseData.toString());
      _resetState();
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _startUploading() async {
    if (_image != null ) {
      final Map<String, dynamic> response = await _uploadImage(_image);
      print("====image_upload======"+response.toString());

      if(response["status"] == true){
        _navigateToNextScreen(context);
      }

      // Check if any error occured
      if (response == null) {
        pr.hide();

      //  messageAllert('User details updated successfully', 'Success');
      }
    } else {
    //  messageAllert('Please Select a photo', 'Profile Photo');
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
  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IdentityCameraBackIDUpload(imagePath:image.path,check_front: true,)),
      );
    });
  }

}