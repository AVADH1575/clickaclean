import 'dart:io';
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/Authentication/ProviderLogin.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/BankDetails/BankDetailsSecond.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/BankDetails/BankDetailsUpdate.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/NotificationHistory/ProviderNotificationHistory.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_third.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/Profile/provider_edit_profile_screen.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/ProviderHelp/ProviderHelp.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/ProviderHistory/Provider_booking_history.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/TermsAndConditions.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/VerifyAccount/IdentityVerificationSubmitVideo.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/VerifyAccount/TermsProfileProvider.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/VerifyAccount/verify_identity_second.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EditIdentity.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

import 'EditWorkPhotos.dart';



class ProvideProfileScreen extends StatefulWidget {

  ProvideProfileScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ProvideProfileScreen();
  }
}

class _ProvideProfileScreen extends State<ProvideProfileScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  File _image;
  List PROFILE_DATA;
  String user_name,email,profile_pic;
  ProgressDialog pr;


  void showInSnackBar(String value) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));}

  Future<dynamic> getProfileData() async {
    //GET_USER_PROFILE_URL
    SharedPreferences myPrefs = await SharedPreferences.getInstance();


    http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_PROFILE_DATA, headers: {
      'x-api-key': myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY),
    });


    var reSPONSE = json.decode(response.body);
    setState(() {

      PROFILE_DATA = reSPONSE["data"];
      user_name = PROFILE_DATA[0]["provider_Firstname"].toString();
      email = PROFILE_DATA[0]["provider_email"].toString();
      profile_pic =  PROFILE_DATA[0]["profile"].toString();

      print("===PROFILE provider_Firstname==="+PROFILE_DATA[0]["provider_Firstname"].toString());
    });

  }
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  @override
  void initState() {
    super.initState();
    getProfileData();

  }
  void open_camera(BuildContext context)
  async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image ;
    });
    Navigator.of(context).pop();

  }
  void open_gallery(BuildContext context)
  async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image ;
    });
    Navigator.of(context).pop();
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
    void _navigateToNextScreen(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProviderNotificationHistory()),
      );
    }
    return Scaffold(
        key: scaffoldKey,
       // appBar: AppBar(title: Text("Identity Verification"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SingleChildScrollView(

            child:
            Container(
                color: Color.fromRGBO(248, 248, 248, 1),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[
                   Column(
                children: <Widget>[
                    Container(
                      color: Color.fromRGBO(248, 248, 248, 1),
                      child:
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 25, 5, 0),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.transparent),),
                            Text("Profile",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1), fontSize: 20),),
                            IconButton(icon: Icon(Icons.notifications_none,color: Color.fromRGBO(240, 122, 71, 1),),
                            onPressed: (){
                              _navigateToNextScreen(context);
                            },
                            ),

                          ],
                        ),),

                    ),
                      Container(
                        color: Color.fromRGBO(248, 248, 248, 1),
                      child:Row(
                       // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[


                         FlatButton(
                         child:new Stack(fit: StackFit.loose,
                             children: <Widget>[
                               new Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                   new Container(
                                       width: 90.0,
                                       height: 90.0,

                           child:  CircleAvatar(
                             backgroundImage: _image == null
                                 ? NetworkImage(profile_pic != null ? profile_pic: ""
                                 )
                                 : FileImage(_image),
                             radius: 50.0,
                           )),
                                 ],
                               ),
                               Padding(
                                   padding: EdgeInsets.only(top: 60.0, left: 65.0,bottom: 15),
                                   child: new Row(

                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[

                                       Container(
                                         height:28,
                                       width:28,
                                           decoration:BoxDecoration(borderRadius: BorderRadius.circular(14.0),color: Color.fromRGBO(39, 180, 221, 1),),

                                         child:
                                         new Icon(
                                           Icons.edit,
                                           color: Colors.white,
                                         ),

                                       )
                                     ],
                                   )),
                             ]),onPressed: (){
                          _onAlertPress(context);
                         },
                       ),
                            ],),
                          Align(
                            alignment: FractionalOffset.topLeft,
                          child:Padding(
                            padding: EdgeInsets.fromLTRB(11, 17, 0, 0),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                            Align(
                            alignment: Alignment.topLeft,

                                child:Text(user_name!= null ? user_name: "",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1), fontSize: 18),textAlign: TextAlign.start,),),
                                Text(email!= null ? email: "",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1), fontSize: 13),),
                                 Icon(Icons.star,color: Colors.transparent,)

                              ],
                            ),),

                          ),



                        ],),),
                     Container(

                       decoration: new BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           color: Colors.white
                       ),
                       margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                       child:Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[

                  Container(
                    //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child:
                    FlatButton(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Account Settings',
                              style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                              textAlign: TextAlign.start
                          ),

                          Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                        ],
                      ),
                    onPressed: (){
                        _navigateToAccountSettingScreen(context);
                    },),
                  ),
                       Container(height: 0.5,color: Color.fromRGBO(0, 0, 0, 0.16)),


                             Container(
                               padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                               child:
                               FlatButton(

                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                                         // SvgPicture.asset('assets/images/passport.svg',height: 18,width: 18,),
                                         Padding(
                                             padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                             child: Text(
                                                 'Identity',
                                                 style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                                 textAlign: TextAlign.start
                                             ))
                                         ,],),
                                     new Container(
                                     ),
                                     Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                                   ],
                                 ),
                               onPressed: (){
                                 Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                     builder: (context) => EditIdentityScreen(), maintainState: false));


                               },
                               ),
                             ),

                             Container(height: 0.5,color: Color.fromRGBO(0, 0, 0, 0.16)),
                             Container(
                               padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                               child:
                               FlatButton(

                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                                         // SvgPicture.asset('assets/images/passport.svg',height: 18,width: 18,),
                                         Padding(
                                             padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                             child: Text(
                                                 'Bank Details',
                                                 style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                                 textAlign: TextAlign.start
                                             )),],),
                                     new Container(
                                     ),
                                     Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                                   ],
                                 ),onPressed: (){
                                 Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                     builder: (context) => BankDetailsUpdate(), maintainState: false));
                               },),
                             ),

                             Container(height: 0.5,color: Color.fromRGBO(0, 0, 0, 0.16)),
                             Container(
                               padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                               child:
                               FlatButton(

                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                                         // SvgPicture.asset('assets/images/passport.svg',height: 18,width: 18,),
                                         Padding(
                                             padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                             child: Text(
                                                 'Add Photos',
                                                 style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                                 textAlign: TextAlign.start
                                             )),],),
                                     new Container(
                                     ),
                                     Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                                   ],
                                 ),onPressed: (){
                                 Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                     builder: (context) => EditWorkPhotos(), maintainState: false));


                               },),
                             ),

                             Container(height: 0.5,color: Color.fromRGBO(0, 0, 0, 0.16)),
                             Container(
                               padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                               child:
                               FlatButton(

                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                                         // SvgPicture.asset('assets/images/passport.svg',height: 18,width: 18,),
                                         Padding(
                                             padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                             child: Text(
                                                 'History',
                                                 style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                                 textAlign: TextAlign.start
                                             )),],),
                                     new Container(
                                     ),
                                     Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                                   ],
                                 ),onPressed: (){
                                 _navigateToBookingHistory(context);
                               },),
                             ),
                            // Container(height: 0.5,color: Color.fromRGBO(0, 0, 0, 0.16)),


                           ],),),
                  Column(


                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Container(
                        //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child:
                        FlatButton(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Terms of Use',
                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                  textAlign: TextAlign.start
                              ),

                              Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                            ],
                          ),onPressed: (){
                          scaffoldKey.currentState
                              .showSnackBar(new SnackBar(content: new Text("Pending")));
                        },),
                      ),
                      Container(height: 0.5,color: Color.fromRGBO(0, 0, 0, 0.16)),


                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child:
                        FlatButton(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SvgPicture.asset('assets/images/passport.svg',height: 18,width: 18,),
                                  Padding(
                                      padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                          'Privacy Policy',
                                          style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                          textAlign: TextAlign.start
                                      )),],),
                              new Container(
                              ),
                              Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                            ],
                          ),onPressed: (){
                          scaffoldKey.currentState
                              .showSnackBar(new SnackBar(content: new Text("Pending")));
                        },),
                      ),

                      Container(height: 0.5,color: Color.fromRGBO(0, 0, 0, 0.16)),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child:
                        FlatButton(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SvgPicture.asset('assets/images/passport.svg',height: 18,width: 18,),
                                  Padding(
                                      padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                          'Help',
                                          style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                          textAlign: TextAlign.start
                                      )),],),
                              new Container(
                              ),
                              Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                            ],
                          ),
                        onPressed: (){
                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                              builder: (context) => ProviderHelpScreen(), maintainState: true));
                        },),
                      ),

                      Container(height: 0.5,color: Color.fromRGBO(0, 0, 0, 0.16)),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child:
                        FlatButton(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SvgPicture.asset('assets/images/passport.svg',height: 18,width: 18,),
                                  Padding(
                                      padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                          'Contact Us',
                                          style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                          textAlign: TextAlign.start
                                      )),],),
                              new Container(
                              ),
                              Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                            ],
                          ),onPressed: (){
                          scaffoldKey.currentState
                              .showSnackBar(new SnackBar(content: new Text("Pending")));
                        },),
                      ),

                      Container(height: 0.5,color: Color.fromRGBO(0, 0, 0, 0.16)),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child:
                        FlatButton(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                children: [
                                  // SvgPicture.asset('assets/images/passport.svg',height: 18,width: 18,),
                                  Padding(
                                      padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                          'Rate App on Playstore',
                                          style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                          textAlign: TextAlign.start
                                      )),],),
                              new Container(
                              ),
                              Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                            ],
                          ),onPressed: (){
                          scaffoldKey.currentState
                              .showSnackBar(new SnackBar(content: new Text("Pending")));
                        },),
                      ),
                      Container(height: 0.5,color: Color.fromRGBO(0, 0, 0, 0.16)),

                    ],)

                       ],),

                    FlatButton(

                      child: Container(
                        child:

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Logout',style: TextStyle(
                                fontSize: 16,fontWeight: FontWeight.bold,
                                color:Color.fromRGBO(255, 0, 0, 1))),
                          ],
                        ),

                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Color.fromRGBO(255, 0, 0, 1),

                      //splashColor: Color.fromRGBO(0, 0, 0, 0.16),

                      onPressed: () {
                        getLogoutData();
                      },
                    )


                  ],))));
  }
  void _navigateToLOGINScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProviderLoginScreen()),
    );
  }
  void _navigateToAccountSettingScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProviderEditProfilePage()),
    );
  }
  void _navigateToEditIdentityScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditIdentityScreen()),
    );
  }
  void _navigateToEditBankDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BankDetailsSecond()),
    );
  }
  void _navigateToBookingHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProviderBookingHistoryTabBar()),
    );
  }
  Future<dynamic> getLogoutData() async {

    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_LOGOUT_API, headers: {
      'x-api-key': myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY),
    });


   var  response_logout = json.decode(response.body);

    setState(() async {

      if(response_logout["status"] == true){

          Fluttertoast.showToast(
              msg: response_logout["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1
          );
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.remove(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);
          _signOut();
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) => ProviderLoginScreen(), maintainState: false));

      }
      else
        {

        }
    });

  }

  //==================================== Functions Area =======================================

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
      APPURLS_PROVIDER.POST_PROVIDER_PROFILE_PHOTO_URL);

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
        'profile', image.path,
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
          msg: responseData["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1
      );
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