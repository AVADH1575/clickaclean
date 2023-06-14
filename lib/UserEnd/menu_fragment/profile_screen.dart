import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/NotificationHistory/UserNotificationHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage> with SingleTickerProviderStateMixin {

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  String USER_API_KEY;
  Map Profile_Map_Data;
  List PROFILE_DATA;
  String user_name,email;
  TextEditingController name_field = new TextEditingController();
  TextEditingController email_field = new TextEditingController();
  TextEditingController mobile_field = new TextEditingController();
  TextEditingController address_field = new TextEditingController();
  TextEditingController town_field = new TextEditingController();
  TextEditingController country_fied = new TextEditingController();
  TextEditingController pincode_fied = new TextEditingController();
  TextEditingController state_fied = new TextEditingController();


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

      name_field = TextEditingController(text: PROFILE_DATA[0]["user_name"].toString() != null ? PROFILE_DATA[0]["user_name"].toString(): "");
      email_field = TextEditingController(text: PROFILE_DATA[0]["email"].toString() != null ?  PROFILE_DATA[0]["email"].toString(): "");
      mobile_field = TextEditingController(text: PROFILE_DATA[0]["phone"].toString() != null ? PROFILE_DATA[0]["phone"].toString(): "");
      address_field = TextEditingController(text: PROFILE_DATA[0]["address"].toString() != null ? PROFILE_DATA[0]["address"].toString(): "");
      town_field = TextEditingController(text: PROFILE_DATA[0]["town"].toString() != null ? PROFILE_DATA[0]["town"].toString(): "");
      country_fied = TextEditingController(text: PROFILE_DATA[0]["country"].toString() != null ? PROFILE_DATA[0]["country"].toString(): "");
      pincode_fied = TextEditingController(text: PROFILE_DATA[0]["pincode"].toString() != null ? PROFILE_DATA[0]["pincode"].toString(): "");
      state_fied = TextEditingController(text: PROFILE_DATA[0]["state"].toString() != null ? PROFILE_DATA[0]["state"].toString(): "");

      print("===PROFILE_DATA data==="+PROFILE_DATA[0]["user_name"].toString());
    });

  }
  Future post_Profile_Update_data() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);

      var client = new http.Client();
      try {
        var response = await client.post(
            APPURLS_USER.GET_USER_PROFILE_UPDATE_URL,
            headers: {"x-api-key": USER_API_KEY
            },
            body: {
              'user_name': name_field.text,
              'phone': mobile_field.text,
              'address': address_field.text,
              'email': email_field.text,
              'pincode': pincode_fied.text,
              'country': country_fied.text,
              'state': state_fied.text,
              'town': town_field.text,

            }

        );

        if (response.statusCode == 200) {
          //enter your code

          print("PROFILE_UPDATE_URL status: ${response.statusCode}");
          print("PROFILE_UPDATE_URL body: ${response.body}");

          final jsonData = json.decode(response.body);

          setState(() {
            if (jsonData["status"] == true) {
              Fluttertoast.showToast(
                  msg: jsonData["message"].toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1
              );

            }

            else {
              print("PROFILE_UPDATE_URL else: ${response.statusCode}");
            }
          });
        }
      } on Exception catch (err) {
        print("Error : $err");

    }
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserNotificationHistory()),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(248, 248, 248, 1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color.fromRGBO(112, 112, 112, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Edit Profile",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1)),),
          centerTitle: true,

          actions: <Widget>[
            // action button
          IconButton(icon: Icon(Icons.notifications_none,color: Color.fromRGBO(125, 121, 204, 1),),
          onPressed: (){
            _navigateToNextScreen(context);
          },
          )

          ],
        ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[

                new Container(
                  alignment:Alignment.topLeft,
                  padding: EdgeInsets.only(top: 20.0,left: 25),
                    child:Text("You can edit your profile. Please Fill your details",textAlign: TextAlign.left, style: TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(125, 121, 204, 1),
              fontWeight: FontWeight.bold),)),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 8.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Parsonal Information',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 5.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Name*',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(125, 121, 204, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 0.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller: name_field,

                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Name",
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,

                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 13.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email*',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(125, 121, 204, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 0.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller: email_field,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Email ID"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 13.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Mobile No.*',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(125, 121, 204, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 0.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller: mobile_field,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Mobile Number"),
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              )),

                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0,bottom: 15),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {

                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                        post_Profile_Update_data();
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );


  }

}

