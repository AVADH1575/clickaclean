import 'dart:async';
import 'package:click_a_clean/UserEnd/menu_fragment/time.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/PaymentSection/Payment.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/home_menu_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:click_a_clean/UserEnd/AddLocation/addressList.dart';

class NewAddress extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
// TODO: implement createState
    return _NewAddress();
  }
}

class _NewAddress extends State<NewAddress> {
  TextEditingController current_text_field_controller = new TextEditingController();
  TextEditingController flat_field_controller = new TextEditingController();
  TextEditingController name_field_controller = new TextEditingController();
  TextEditingController phone_field_controller = new TextEditingController();
  TextEditingController key_collection_field_controller = new TextEditingController();
  TextEditingController gate_code_field_controller = new TextEditingController();

  int _radioValue1 = -1;
  int correctScore = 0;
  double lat,long;
  String Full_address;
  final Map<String, Marker> _markers = {};
  var currentLocation;
  List sERVICE_TYPE_LIST_DATA;
  String service_name,USER_API_KEY;
  SharedPreferences myPrefs;

  void _getLocation() async {
    myPrefs = await SharedPreferences.getInstance();
     currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
     final coordinates = new Coordinates(currentLocation.latitude, currentLocation.longitude);
     var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
     var first = addresses.first;
     Full_address = first.addressLine;
     current_text_field_controller = TextEditingController(text: Full_address);
     print("===current address===== "+Full_address);


     setState(() {
      _markers.clear();
      lat = currentLocation.latitude;
      long = currentLocation.longitude;

       final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Current Location'),
      );
      _markers["Current Location"] = marker;
    });
  }

  Future getDataServiceType() async {
     myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);
    http.Response response =  await http.get(APPURLS_USER.GET_USER_CHECK_SERVICE_NAME, headers: {
      'x-api-key': USER_API_KEY,
    });

    var resBody = json.decode(response.body);
    setState(() {
      sERVICE_TYPE_LIST_DATA = resBody["data"];
      print("===service_type_data==="+sERVICE_TYPE_LIST_DATA.toString());
      service_name = sERVICE_TYPE_LIST_DATA[0]["servicename"].toString();

    });

  }



  Future post_Address_data() async {
    myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);


    if( myPrefs.getString(STORE_PREFS.USER_ADDRESS_TYPE_SELECTION) == null){
      Fluttertoast.showToast(
          msg: "Please enter required field",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1);
    }else {
      var client = new http.Client();
      try {
        var response = await client.post(
            APPURLS_USER.POST_USER_ADD_ADDRESS_URL,
            headers: {"x-api-key": USER_API_KEY
            },
            body: {
              'address': current_text_field_controller.text,
              'flat': flat_field_controller.text,
              'name': name_field_controller.text,
              'phone': phone_field_controller.text,
              'code': gate_code_field_controller.text,
              'keyfile': key_collection_field_controller.text,
              'type': myPrefs.getString(STORE_PREFS.USER_ADDRESS_TYPE_SELECTION)
                  .toString(),
              'lat': lat.toString(),
              'log': long.toString(),
            }

        );

        if (response.statusCode == 200) {
          //enter your code

          print("Address_ListResponse status: ${response.statusCode}");
          print("Address_ListResponse body: ${response.body}");

          final jsonData = json.decode(response.body);

          setState(() {
            if (jsonData["status"] == true) {
              Fluttertoast.showToast(
                  msg: jsonData["message"].toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1
              );
              _navigateToNextScreen(context);
            }

            else {
              print("Address_ListResponse else: ${response.statusCode}");
            }
          });
        }
      } on Exception catch (err) {
        print("Error : $err");
      }
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getLocation();
    getDataServiceType();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 121, 204, 1),
        title: Text(service_name!=null?service_name: ""),
        centerTitle: true,

      ),
      body: SingleChildScrollView(

      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[

    lat == null || long == null

              ?Container(
                height: 200,):
    Container(   height: 200,
    child:GoogleMap(
                  mapType: MapType.normal,
                 myLocationButtonEnabled: true,
                 myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat ?? 0, long ?? 0),
                    zoom: 17,
                  ),
                  markers: _markers.values.toSet(),
                ),
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
                              left: 25.0, right: 25.0, top: 15.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(

                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[

                                  new Text(
                                    'Your Current Location',
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


                                ],
                              )
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
                                   controller: current_text_field_controller,

                                  decoration: const InputDecoration(
                                    hintText: "Park Avenue Street17 , Paris , France",

                                  ),
// enabled: !_status,
// autofocus: !_status,

                                ),
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
                                  controller: flat_field_controller,
                                  decoration: const InputDecoration(
                                      hintText: "Flat / Building / Street"),
//enabled: !_status,
                                ),
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
                                  controller: name_field_controller,
                                  decoration: const InputDecoration(
                                      hintText: "Your Name"),
// enabled: !_status,
                                ),
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
                                  controller: phone_field_controller,
                                  decoration: const InputDecoration(
                                      hintText: "Phone Number"),
// enabled: !_status,
                                ),
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
                                  controller: key_collection_field_controller,
                                  decoration: const InputDecoration(
                                      hintText: "Key Collection Instructions"),
// enabled: !_status,
                                ),
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
                                  controller: gate_code_field_controller,
                                  decoration: const InputDecoration(
                                      hintText: "Gate codes Instructions"),
// enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 15.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(

                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[

                                  new Text(
                                    'Save As',
                                    style: TextStyle(
                                        color:Colors.deepPurpleAccent,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              new Column(

                              )
                            ],
                          )),
                      new Container(
                        padding: EdgeInsets.all(3.0),
                        child: Row(


                          children: <Widget>[
                            Container(
                              padding:EdgeInsets.only(left:20.0),
                            child:RaisedButton(
                              color: Colors.white,
                              onPressed: ()  {

                                setState(() {
                                  Fluttertoast.showToast(
                                      msg: "Home Selected",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIos: 1
                                  );

                              myPrefs.setString(STORE_PREFS.USER_ADDRESS_TYPE_SELECTION,"Home");

                                });
                                },
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Color.fromRGBO(125, 121, 204, 1), width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text("Home",style: TextStyle(
                                                 fontSize: 13,
                                  color: Color.fromRGBO(125, 121, 204, 1),)),
                            ),),

                            Container(
                              padding:EdgeInsets.only(left:5.0),
                              child:RaisedButton(
                                onPressed: () {
                                  Fluttertoast.showToast(
                                      msg: "Office Selected",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIos: 1
                                  );
                                  myPrefs.setString(STORE_PREFS.USER_ADDRESS_TYPE_SELECTION,"Office");

                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color.fromRGBO(125, 121, 204, 1), width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text("Office",style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(125, 121, 204, 1),)),
                              ),),
                            Container(
                              padding:EdgeInsets.only(left:5.0),
                              child:RaisedButton(
                                onPressed: () {
                                  Fluttertoast.showToast(
                                      msg: "Other Selected",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIos: 1
                                  );
                                  myPrefs.setString(STORE_PREFS.USER_ADDRESS_TYPE_SELECTION,"Other");

                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color.fromRGBO(125, 121, 204, 1), width: 1),
                                    borderRadius: BorderRadius.circular(10)),

                                child: Text("Other",style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(125, 121, 204, 1),)),
                              ),),

                          ],
                        ),
                      )

// !status ? getActionButtons() : new Container(),
                    ],
                  ),
                ),
              ),



            ],),



        ],

      ),),
      bottomNavigationBar: new Container(

        color: Color.fromRGBO(125, 121, 204, 1),
        height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[


                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: FlatButton(
                    child:Align(
                      alignment: FractionalOffset.center,
                    ),
                  ),),



                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: FlatButton(
                    child:Align(
                      alignment: FractionalOffset.center,
                      child: Text(
                        "Save Address",style: TextStyle(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,

                      ),),onPressed: (){


                     validation();

                  },
                  )
                  ,),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: FlatButton(
                    child:Align(
                      alignment: FractionalOffset.center,
                    ),
                  ),),
              ],),
          ),
    );
  }
  String validation() {

    if (current_text_field_controller.text.length == 0) {
      Fluttertoast.showToast(msg: "Please enter address");
      return "Please enter this field";
    }
    else if (flat_field_controller.text.length == 0) {
      Fluttertoast.showToast(msg: "Please enter flat/building field");
      return "Please enter this field";
    }
    else if (name_field_controller.text.length == 0) {
      Fluttertoast.showToast(msg: "Please enter your name");
      return "Please enter this field";
    }
    else if (phone_field_controller.text.length == 0) {
      Fluttertoast.showToast(msg: "Please enter your phone number");
      return "Please enter this field";
    }
    else if (gate_code_field_controller.text.length == 0) {
      Fluttertoast.showToast(msg: "Please enter gate code instruction");
      return "Please enter this field";
    } else if (key_collection_field_controller.text.length == 0) {
      Fluttertoast.showToast(msg: "Please enter key instruction");
      return "Please enter this field";
    } else if (myPrefs.getString(STORE_PREFS.USER_ADDRESS_TYPE_SELECTION)
    .toString() != "Home" && myPrefs.getString(STORE_PREFS.USER_ADDRESS_TYPE_SELECTION)
        .toString() != "Office" && myPrefs.getString(STORE_PREFS.USER_ADDRESS_TYPE_SELECTION)
        .toString() != "Other") {
      Fluttertoast.showToast(msg: "Please select address type");
      return "Please enter this field";
    }


    else {
      myPrefs.setString(STORE_PREFS.USER_BOOKING_ADDRESS,current_text_field_controller.text.toString());
      myPrefs.setString(STORE_PREFS.USER_BOOKING_FLAT,flat_field_controller.text.toString());
      myPrefs.setString(STORE_PREFS.USER_BOOKING_ADDRESS_NAME,name_field_controller.text.toString());
      myPrefs.setString(STORE_PREFS.USER_BOOKING_PHONE,phone_field_controller.text.toString());
      myPrefs.setString(STORE_PREFS.USER_BOOKING_INSTRUCTION_CODE,gate_code_field_controller.text.toString());
      myPrefs.setString(STORE_PREFS.USER_BOOKING_KEYFILE_NAME,key_collection_field_controller.text.toString());
      myPrefs.setString(STORE_PREFS.USER_BOOKING_SAVED_ADDRESS_TYPE,myPrefs.getString(STORE_PREFS.USER_ADDRESS_TYPE_SELECTION)
          .toString());
      myPrefs.setString(STORE_PREFS.USER_BOOKING_LAT,lat.toString());
      myPrefs.setString(STORE_PREFS.USER_BOOKING_LOG,long.toString());
      post_Address_data();
    }
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Time()),
    );
  }

  void _navigateToBackScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddressList()),
    );
  }

}