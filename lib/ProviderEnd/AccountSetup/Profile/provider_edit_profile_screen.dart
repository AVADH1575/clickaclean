import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProviderEditProfilePage extends StatefulWidget {
  @override
  _ProviderEditProfilePage createState() => _ProviderEditProfilePage();
}

class _ProviderEditProfilePage extends State<ProviderEditProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  Choice _selectedChoice = choices[0]; // The app's "state".
  Map Profile_Map_Data;
  List PROFILE_DATA;
  String user_name,email,dob,middle_name;
  TextEditingController name_field = new TextEditingController();
  TextEditingController last_name_field = new TextEditingController();
  TextEditingController email_field = new TextEditingController();
  TextEditingController mobile_field = new TextEditingController();
  TextEditingController address_field = new TextEditingController();
  TextEditingController town_field = new TextEditingController();
  TextEditingController country_fied = new TextEditingController();
  TextEditingController pincode_fied = new TextEditingController();
  TextEditingController state_fied = new TextEditingController();

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  Future<dynamic> getProfileData() async {
    //GET_USER_PROFILE_URL
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_PROFILE_DATA, headers: {
      'x-api-key': myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY),
    });


    var reSPONSE = json.decode(response.body);
    setState(() {
      PROFILE_DATA = reSPONSE["data"];

      name_field = TextEditingController(text: PROFILE_DATA[0]["provider_Firstname"].toString() != null ? PROFILE_DATA[0]["provider_Firstname"].toString(): "" + PROFILE_DATA[0]["provider_Lastname"].toString() != null ? PROFILE_DATA[0]["provider_Lastname"].toString(): "");
      last_name_field = TextEditingController(text: PROFILE_DATA[0]["provider_Lastname"].toString() != null ?  PROFILE_DATA[0]["provider_Lastname"].toString(): "");
      email_field = TextEditingController(text: PROFILE_DATA[0]["provider_email"].toString() != null ?  PROFILE_DATA[0]["provider_email"].toString(): "");
      mobile_field = TextEditingController(text: PROFILE_DATA[0]["provider_phone"].toString() != null ? PROFILE_DATA[0]["provider_phone"].toString(): "");
      address_field = TextEditingController(text: PROFILE_DATA[0]["provider_address"].toString() != null ? PROFILE_DATA[0]["provider_address"].toString(): "");
      town_field = TextEditingController(text: PROFILE_DATA[0]["provider_town"].toString() != null ? PROFILE_DATA[0]["provider_town"].toString(): "");
      country_fied = TextEditingController(text: PROFILE_DATA[0]["provider_country"].toString() != null ? PROFILE_DATA[0]["provider_country"].toString(): "");
      pincode_fied = TextEditingController(text: PROFILE_DATA[0]["provider_pincode"].toString() != null ? PROFILE_DATA[0]["provider_pincode"].toString(): "");
      state_fied = TextEditingController(text: PROFILE_DATA[0]["provider_state"].toString() != null ? PROFILE_DATA[0]["provider_state"].toString(): "");
      dob = PROFILE_DATA[0]["provider_dob"].toString() != null ?  PROFILE_DATA[0]["provider_dob"].toString(): "";
      middle_name = PROFILE_DATA[0]["provider_Middlename"].toString() != null ?  PROFILE_DATA[0]["provider_Middlename"].toString(): "";

      print("===PROFILE_DATA data==="+PROFILE_DATA[0]["provider_Firstname"].toString());
    });

  }

  Future post_Profile_Update_data() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();


    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_PROVIDER.POST_PROVIDER_PERSONAL_INFORMATION_URL,
          headers: {"x-api-key": myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY)
          },
          body: {
            'provider_Firstname': name_field.text,
            'provider_Lastname': last_name_field.text,
            'provider_address': address_field.text,
            'provider_email': email_field.text,
            'provider_pincode': pincode_fied.text,
            'provider_country': country_fied.text,
            'provider_state': state_fied.text,
            'provider_town': town_field.text,
            'provider_dob': dob,
            'provider_phone': mobile_field.text,
            'provider_Middlename': middle_name,

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
          backgroundColor: Color.fromRGBO(241, 123, 72, 1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Account Setting",style: TextStyle(color: Colors.white),),
          centerTitle: true,


        ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    child: Padding(
          padding:  EdgeInsets.only(
          left: 25.0, right: 25.0, top: 15.0,bottom: 10),

          child:Text("Please enter your details as they appear on your identification documents.",style: TextStyle(
              fontSize: 15.0,
             color: Color.fromRGBO(255, 51, 51, 1)),
          ),),

                  ),
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
                                  left: 25.0, right: 25.0, top: 5.0),
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
                                        'First Name*',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(241, 123, 72, 1),
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
                                        hintText: "Enter Your First Name",
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,

                                    ),
                                  ),
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
                                        'Last Name*',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(241, 123, 72, 1),
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
                                      controller: last_name_field,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Last Name",
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
                                            color: Color.fromRGBO(241, 123, 72, 1),
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
//                          Padding(
//                              padding: EdgeInsets.only(
//                                  left: 25.0, right: 25.0, top: 13.0),
//                              child: new Row(
//                                mainAxisSize: MainAxisSize.max,
//                                children: <Widget>[
//                                  new Column(
//                                    mainAxisAlignment: MainAxisAlignment.start,
//                                    mainAxisSize: MainAxisSize.min,
//                                    children: <Widget>[
//                                      new Text(
//                                        'D.O.B*',
//                                        style: TextStyle(
//                                            fontSize: 14.0,
//                                            color: Color.fromRGBO(241, 123, 72, 1),
//                                            fontWeight: FontWeight.bold),
//                                      ),
//                                    ],
//                                  ),
//                                ],
//                              )),
//                          Padding(
//                              padding: EdgeInsets.only(
//                                  left: 25.0, right: 25.0, top: 0.0),
//                              child: new Row(
//                                mainAxisSize: MainAxisSize.max,
//                                children: <Widget>[
//                                  new Flexible(
//                                    child: new TextField(
//                                      decoration: const InputDecoration(
//                                          hintText: "Enter DOB"),
//                                      enabled: !_status,
//                                    ),
//                                  ),
//                                ],
//                              )),
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
                                            color: Color.fromRGBO(241, 123, 72, 1),
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
                                        'Address',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(241, 123, 72, 1),
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
                                      controller: address_field,
                                      decoration: const InputDecoration(
                                          hintText: "#123,abc"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
//                          Padding(
//                              padding: EdgeInsets.only(
//                                  left: 25.0, right: 25.0, top: 13.0),
//                              child: new Row(
//                                mainAxisSize: MainAxisSize.max,
//                                children: <Widget>[
//                                  new Column(
//                                    mainAxisAlignment: MainAxisAlignment.start,
//                                    mainAxisSize: MainAxisSize.min,
//                                    children: <Widget>[
//                                      new Text(
//                                        'Address line 2',
//                                        style: TextStyle(
//                                            fontSize: 14.0,
//                                            color: Color.fromRGBO(241, 123, 72, 1),
//                                            fontWeight: FontWeight.bold),
//                                      ),
//                                    ],
//                                  ),
//                                ],
//                              )),
//                          Padding(
//                              padding: EdgeInsets.only(
//                                  left: 25.0, right: 25.0, top: 0.0),
//                              child: new Row(
//                                mainAxisSize: MainAxisSize.max,
//                                children: <Widget>[
//                                  new Flexible(
//                                    child: new TextField(
//                                      decoration: const InputDecoration(
//                                          hintText: "#123,abc"),
//                                      enabled: !_status,
//                                    ),
//                                  ),
//                                ],
//                              )),
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
                                        'Town*',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(241, 123, 72, 1),
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
                                      controller: town_field,
                                      decoration: const InputDecoration(
                                          hintText: "panchkula"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
//                          Padding(
//                              padding: EdgeInsets.only(
//                                  left: 25.0, right: 25.0, top: 13.0),
//                              child: new Row(
//                                mainAxisSize: MainAxisSize.max,
//                                children: <Widget>[
//                                  new Column(
//                                    mainAxisAlignment: MainAxisAlignment.start,
//                                    mainAxisSize: MainAxisSize.min,
//                                    children: <Widget>[
//                                      new Text(
//                                        'Country*',
//                                        style: TextStyle(
//                                            fontSize: 14.0,
//                                            color: Color.fromRGBO(241, 123, 72, 1),
//                                            fontWeight: FontWeight.bold),
//                                      ),
//                                    ],
//                                  ),
//                                ],
//                              )),
//                          Padding(
//                              padding: EdgeInsets.only(
//                                  left: 25.0, right: 25.0, top: 0.0),
//                              child: new Row(
//                                mainAxisSize: MainAxisSize.max,
//                                children: <Widget>[
//                                  new Flexible(
//                                    child: new TextField(
//
//                                      decoration: const InputDecoration(
//                                          hintText: "India"),
//                                      enabled: !_status,
//                                    ),
//                                  ),
//                                ],
//                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 13.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Pin Code',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(241, 123, 72, 1),

                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'State',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(241, 123, 72, 1),

                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 0.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new TextField(
                                        controller: pincode_fied,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Pin Code"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      controller: state_fied,
                                      decoration: const InputDecoration(
                                          hintText: "Enter State"),
                                      enabled: !_status,
                                    ),
                                    flex: 2,
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
class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '', icon: Icons.directions_car),
  const Choice(title: '', icon: Icons.directions_bike),
  const Choice(title: 'Manage Location', icon: Icons.directions_boat),
  const Choice(title: 'My favorites', icon: Icons.directions_bus),
  const Choice(title: 'Share', icon: Icons.directions_railway),
  const Choice(title: 'Logout', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }}