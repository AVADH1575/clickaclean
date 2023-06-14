import 'dart:io';

import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_second.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/Profile/provider_profile_screen.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:http_parser/http_parser.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EditWorkPhotos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditWorkPhotos();
  }
}
class _EditWorkPhotos extends State<EditWorkPhotos> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  List Document_list = List();
  String doc_type,idFront,idBack;
  SharedPreferences myPrefs;
  String document_type;
  File _image;
  ProgressDialog pr;

  Map building_data;

  List building_type_data;
  int _selectedIndex,_selected_Index_second;
  _onSelected(int index) {

    setState(() {
      _selectedIndex = index;
    });
  }

  Future<String> getIdentityData() async {
    myPrefs = await SharedPreferences.getInstance();

    var res = await http
        .get(Uri.encodeFull(APPURLS_PROVIDER.GET_PROVIDER_WORK_IMAGES), headers: { 'x-api-key':  myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY)});
    var resBody = json.decode(res.body);

    setState(() {
      //select_size_data = resBody;
      Document_list = resBody["data"];

    });

    print(resBody);
    return "Success";
  }

  Future getBuildingData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();


    http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_WORK_IMAGES, headers: {
      'x-api-key': myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY),
    });


    building_data = json.decode(response.body);
    setState(() {
      building_type_data = building_data["data"];
print("====list_images==="+building_type_data.toString());
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBuildingData();
  }
  @override
  Widget build(BuildContext context) {
//============================================= loading dialoge
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

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
    getBuildingData();
    return Scaffold(
        appBar: AppBar(title: Text("Photos"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SafeArea(

    child:SingleChildScrollView(
            child:
            Align(

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[

                    Column(
                        children: <Widget>[
                          Container(
                            margin:  EdgeInsets.fromLTRB(33, 29, 33, 0),

                           child: FlatButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: <Widget>[
                                  Column(


                                    children: <Widget>[
                                       Padding(
                                          padding: EdgeInsets.only(top: 6, left: 2, bottom: 4),
                                          child: Text( "Upload your work photos",textAlign:TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 16))),
                                    ],),

                                ],
                              ),
                            ),

                          ),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: (){
                                    _onAlertPress(context);
                                  },
                                child:Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                    padding: EdgeInsets.only(top: 10,right: 10),
                                    height: 120,
                                    width: 139,
                                    child: Image.asset("assets/images/add_photos.png"),
                                )),
                              ]),

                          new GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: building_type_data == null ? 0 : building_type_data.length,

                            padding: const EdgeInsets.only(left:20.0,right: 20,),

                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(

                                  onTap: () {
                                    setState(() {
                                      _onSelected(index);


                                    });

                                    print("${building_type_data[index]['id'].toString()}");
                                  },
                                  child:Container(
                                    decoration: BoxDecoration(
                                      color:  _selectedIndex != null && _selectedIndex == index
                                          ? Color.fromRGBO(250, 250, 250, 1)
                                          : Colors.transparent,
                                      border: Border.all(
                                        color:  _selectedIndex != null && _selectedIndex == index
                                            ? Color.fromRGBO(125, 121, 204, 1)
                                            : Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                              children:<Widget>[
                                                Container(
                                                    height: 139,
                                                    width: 139,
                                                    child: FadeInImage.assetNetwork(
                                                      placeholder: 'assets/images/background_image.png',
                                                      image: building_type_data[index]["images"],fit: BoxFit.cover,
                                                    )

                                                ),
                                                   ]),

                                        ],
                                      ),
                                    ),
                                  ));

                            },
                          ),

                        ]),



//                    Align(
//                      alignment: Alignment.center,
//
//                      child:Container(
//
//                        color: Color.fromRGBO(241, 123, 72, 1),
//                        height: 49,
//
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Align(
//                              alignment: FractionalOffset.bottomRight,
//                              child: FlatButton(
//                                onPressed: (){
//                                  //_navigateToNextScreen(context);
//                                },
//                                child: Row(
//
//                                  children: <Widget>[
//                                    Row(
//
//                                      children: <Widget>[
//                                        FlatButton(
//                                            onPressed: () {},
//                                            child: Column(
//                                              children: <Widget>[
//
//
//                                              ],)
//                                        ),
//                                      ],),
//
//                                  ],
//                                ),
//                              ),),
//                            Align(
//                              alignment: FractionalOffset.bottomRight,
//                              child: FlatButton(
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: <Widget>[
//                                    Row(
//                                      mainAxisAlignment: MainAxisAlignment.center,
//                                      crossAxisAlignment: CrossAxisAlignment.center,
//                                      children: <Widget>[
//                                        Align(
//                                          alignment: FractionalOffset.center,
//                                          child:FlatButton(
//                                              onPressed: () {
//                                                // _navigateToNextScreen(context);
//                                              },
//                                              child: Row(
//                                                mainAxisAlignment: MainAxisAlignment.center,
//                                                crossAxisAlignment: CrossAxisAlignment.center,
//                                                children: <Widget>[
//                                                  Text("SAVE",style: TextStyle(color: Colors.white,fontSize: 16)),
//                                                  Icon(Icons.arrow_forward_ios,color: Colors.white,)
//                                                ],)
//                                          ),),
//                                      ],),
//                                  ],
//                                ),
//                              ),),
//                          ],),
//                      ),)
                  ],)))));
  }

  //========================= Gellary / Camera AlerBox  =======================================
  Future<void>  _onAlertPress(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/gallery.png',
                      width: 50,
                    ),
                    Text('Gallery'),
                  ],
                ),
                onPressed: (){
                  getGalleryImage(context);
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/take_picture.png',
                      width: 50,
                    ),
                    Text('Take Photo'),
                  ],
                ),
                onPressed: (){
                  getCameraImage(context);
                },
              ),
            ],
          );
        });
  }


  // ================================= Image from camera ==============================================
  Future getCameraImage(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      Navigator.pop(context);
      _startUploading();
    });
  }

  //============================== Image from gallery ==================================================
  Future getGalleryImage(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      Navigator.pop(context);
      _startUploading();
    });
  }

  //================================= API Area to upload image ==========================================
  Uri apiUrl = Uri.parse(
      APPURLS_PROVIDER.POST_PROVIDER_ADD_WORK_IMAGES);

  Future<Map<String, dynamic>> _uploadImage(File image) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    setState(() {

      pr.show();
    });

    final mimeTypeData =
    lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

    Map<String, String> headers = { "x-api-key": myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY)};
    // Initialize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath(
        'images', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.files.add(file);
    imageUploadRequest.headers.addAll(headers);
    // imageUploadRequest.fields['name'] = "";

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("====image_upload==response_Data======"+responseData.toString());

      Fluttertoast.showToast(
          msg: "Photo uploaded successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1
      );
      getBuildingData();
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
      // Check if any error occured
      if (response == null) {
        pr.hide();
        //messageAllert('User details updated successfully', 'Success');
      }
    } else {
      // messageAllert('Please Select a profile photo', 'Profile Photo');
    }
  }

  void _resetState() {
    setState(() {
      pr.hide();

      getBuildingData();
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

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProvideProfileScreen()),
    );
  }

}