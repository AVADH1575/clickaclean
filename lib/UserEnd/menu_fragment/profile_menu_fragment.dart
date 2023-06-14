import 'dart:io';
import 'dart:convert';
import 'package:click_a_clean/UserEnd/AddLocation/ManageAddress.dart';
import 'package:click_a_clean/UserEnd/AddLocation/addressList.dart';
import 'package:click_a_clean/UserEnd/NotificationHistory/UserNotificationHistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/PaymentSection/PaymentOptions.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/FavouriteScreen.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/NotificationsHistory.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/help_menu_fragment.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';


class ProfileMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileMenu();
  }
}
class _ProfileMenu extends State<ProfileMenu> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  File _image;
  String USER_API_KEY;
  Map Profile_Map_Data;
  List PROFILE_DATA;
  String user_name,email,profile_pic;
  ProgressDialog pr;


  void showInSnackBar(String value) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));}


  Future<dynamic> getProfileData() async {
    //GET_USER_PROFILE_URL
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

    http.Response response =  await http.get(APPURLS_USER.GET_USER_PROFILE_URL, headers: {
      'x-api-key': USER_API_KEY,
    });


    var reSPONSE = json.decode(response.body);
    setState(() {
      PROFILE_DATA = reSPONSE;

      user_name = PROFILE_DATA[0]["user_name"].toString();
      email = PROFILE_DATA[0]["email"].toString();
      profile_pic =  PROFILE_DATA[0]["profile"].toString();

      print("===PROFILE_DATA data==="+PROFILE_DATA[0]["user_name"].toString());
    });

  }
  Future<dynamic> getLogoutData() async {

    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    http.Response response =  await http.get(APPURLS_USER.GET_USER_LOGOUT_API, headers: {
      'x-api-key': myPrefs.getString(STORE_PREFS.USER_API_KEY),
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
        await preferences.remove(STORE_PREFS.USER_API_KEY);
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) => LoginScreen(), maintainState: false));

      }
      else
      {

      }
    });

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

    return Scaffold(
        key: scaffoldKey,

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

                                IconButton(icon: Icon(Icons.arrow_back_ios,color: Color.fromRGBO(248, 248, 248, 1),),),
                                Text("Profile",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1), fontSize: 20),),
                                IconButton(onPressed: (){
                                  _navigateToNotificationScreen(context);
                                },icon: Icon(Icons.notifications_none,color: Color.fromRGBO(125, 121, 204, 1))),

                              ],
                            ),),

                        ),
                        Container(
                          color: Color.fromRGBO(248, 248, 248, 1),
                          child:Row(
                             mainAxisAlignment: MainAxisAlignment.center,
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

                                      child:


                                 Image(
                                          image: _image == null
                                              ? AssetImage("assets/images/avatar_bg.png")

                                              :  NetworkImage(profile_pic != null ? profile_pic: ""),
                          ),

                                      //  radius: 50.0,
                                      )


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


                            ],),),
                        Container(

                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(0.0),
                              color: Colors.white
                          ),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Container(

                                child:
                                FlatButton(

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Row(
                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                       Icon(Icons.account_box,color: Color.fromRGBO(129, 130, 130, 1),),
                                     Padding(
                                          padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
                                      child:Text(

                                          'Account Settings',
                                          style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                          textAlign: TextAlign.start
                                      )),],),

                                     // Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                                    ],
                                  ),
                                  onPressed: (){
                                    _navigateToNextScreen(context);
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
                                          Icon(Icons.location_on,color: Color.fromRGBO(129, 130, 130, 1),),
                                          Padding(
                                              padding:  EdgeInsets.fromLTRB(18, 0, 0, 0),
                                              child: Text(
                                                  'Manage Address',
                                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                                  textAlign: TextAlign.start
                                              )),],),
                                      new Container(
                                      ),
                                    ],
                                  ),onPressed: (){
                                    _navigateToFavouriteScreen(context);
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
                                          Icon(Icons.notifications,color: Color.fromRGBO(129, 130, 130, 1),),
                                          Padding(
                                              padding:  EdgeInsets.fromLTRB(18, 0, 0, 0),
                                              child: Text(
                                                  'Notifications',
                                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                                  textAlign: TextAlign.start
                                              )),],),
                                      new Container(
                                      ),
                                    ],
                                  ),onPressed: (){
                                    _navigateToNotificationScreen(context);
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
                                          Icon(Icons.help,color: Color.fromRGBO(129, 130, 130, 1),),
                                          Padding(
                                              padding:  EdgeInsets.fromLTRB(18, 0, 0, 0),
                                              child: Text(
                                                  'Help Center',
                                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                                  textAlign: TextAlign.start
                                              )),],),
                                      new Container(
                                      ),
                                      //Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                                    ],
                                  ),
                                onPressed: (){
                                  _navigateToHelpScreen(context);
                                },),
                              ),
                              // Container(height: 0.5,color: Color.fromRGBO(0, 0, 0, 0.16)),

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
                                          Icon(Icons.share,color: Color.fromRGBO(129, 130, 130, 1),),
                                          Padding(
                                              padding:  EdgeInsets.fromLTRB(18, 0, 0, 0),
                                              child: Text(
                                                  'Share App',
                                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                                  textAlign: TextAlign.start
                                              )),],),
                                      new Container(
                                      ),
                                      //Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
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
                                          Icon(Icons.star,color: Color.fromRGBO(129, 130, 130, 1),),
                                          Padding(
                                              padding:  EdgeInsets.fromLTRB(18, 0, 0, 0),
                                              child: Text(
                                                  'Rate App on Playstore',
                                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 15),
                                                  textAlign: TextAlign.start
                                              )
                                          ),],),
                                      new Container(
                                      ),
                                      //Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(129, 130, 130, 1))
                                    ],
                                  ),onPressed: (){
                                  scaffoldKey.currentState
                                      .showSnackBar(new SnackBar(content: new Text("Pending")));
                                },),
                              ),
                              Container(height: 1),
                            ],),),

                      ],),

                    FlatButton(

                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 38, 0, 0),
                        child:

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Logout',style: TextStyle(
                                fontSize: 16,fontWeight: FontWeight.bold,
                                color:Color.fromRGBO(255, 0, 0, 1))),
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
                      textColor: Color.fromRGBO(255, 0, 0, 1),

                      //splashColor: Color.fromRGBO(0, 0, 0, 0.16),

                      onPressed: () {
                        getLogoutData();
                        //_navigateToNextScreen(context);
                      },
                    )


                  ],))));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }
  void _navigateToHelpScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Help_Menu()),
    );
  }
  void _navigateToNotificationScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserNotificationHistory()),
    );
  }
  void _navigateToFavouriteScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ManageAddress()),
    );
  }
  void _navigateToPaymentScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentOptions()),
    );
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
      APPURLS_USER.POST_USER_PROFILE_PIC_UPDATE_URL);

  Future<Map<String, dynamic>> _uploadImage(File image) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    setState(() {

      pr.show();
    });

    final mimeTypeData =
    lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

    Map<String, String> headers = { "x-api-key": myPrefs.getString(STORE_PREFS.USER_API_KEY)};
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