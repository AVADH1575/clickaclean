import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/PaymentSection/Payment.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/home_menu_fragment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class TrackOrder extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
// TODO: implement createState

    return _TrackOrder();
  }
}

class _TrackOrder extends State<TrackOrder> {
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  bool thuVal = false;
  int correctScore = 0;
  String USER_API_KEY,service_name,USER_CAR_DATe,USER_CAR_TIMe;
  String Car_type_headline, Valter_type_headline, booking_date, booking_time,car_type,booking_type,valter_type,booking_price,title_name,working_status;
  double lat,long;
  String Full_address;
  final Map<String, Marker> _markers = {};
  var currentLocation;
  SharedPreferences myPrefs;
  String image_status_request = "";
  String image_status_accept = "";
  String image_status_in_progress = "";
  String image_status_complete = "";

  @override
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  File _image;
  void showInSnackBar(String value) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));}

  @override
  void initState() {
    super.initState();
    _getLocation();
    PostTrackOredrApi();
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


  Future PostTrackOredrApi() async {
    myPrefs = await SharedPreferences.getInstance();
    USER_API_KEY = myPrefs.getString(STORE_PREFS.USER_API_KEY);


    var client = new http.Client();

    try {
      var response = await client.post(
          APPURLS_USER.POST_USER_TRACK_BOOKING_URL,
          headers: {"x-api-key": USER_API_KEY
          },
          body: {
            'id': myPrefs.getString(STORE_PREFS.USER_ACTIVE_BOOKING_ID),

          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {

            Fluttertoast.showToast(msg: jsonData["message"].toString());

          print("======response====track===="+jsonData["data"].toString());

            service_name = jsonData["data"][0]["service_type"].toString();
            car_type = jsonData["data"][0]["car_type"].toString();
            booking_date = jsonData["data"][0]["userDate"].toString();
            booking_time = jsonData["data"][0]["userTime"].toString();
            booking_price = jsonData["data"][0]["price"].toString();
            working_status = jsonData["data"][0]["workStatus"].toString();


    print("=====service_name===="+service_name);
            if(service_name == "1"){
              Car_type_headline = "Building Details";
              Valter_type_headline = "Pets love & Room Details";
              title_name = "Domestic Cleaner";

              booking_type = "Building Type: "+ jsonData["data"][0]["pets"].toString() + " , Building Size: " +jsonData["data"][0]["building_size"].toString();
              valter_type = "Pets love: " +jsonData["data"][0]["pets"].toString() + " , No. of Rooms: " + jsonData["data"][0]["room_size"].toString();

            }
            else{
              Car_type_headline = "Car Valeter";
              Valter_type_headline = "Valeter Type";
              title_name = "Car Cleaner";


              if (car_type == "1"){
                booking_type = "Car";
              }
              if (car_type == "2"){
                booking_type = "4x4";
              }
              if (car_type == "3"){
                booking_type = "Van";
              }
              valter_type = "Valet" + " " +jsonData["data"][0]["service"].toString();

            }



          }

          else {
            Fluttertoast.showToast(msg: jsonData["message"].toString());
          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }





  void _getLocation() async {
    myPrefs = await SharedPreferences.getInstance();
    currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    final coordinates = new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    Full_address = first.addressLine;
//    current_text_field_controller = TextEditingController(text: Full_address);
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

  @override
  Widget build(BuildContext context) {

     if (working_status == "Ongoing"){

       image_status_request = "assets/images/circle-filled.png";
       image_status_accept = "assets/images/circle-filled.png";
       image_status_in_progress  = "assets/images/circle-filled.png";
       image_status_complete = "assets/images/circle-unfilled.png";

     }
     else if (working_status == "Accepted"){

       image_status_request = "assets/images/circle-filled.png";
       image_status_accept = "assets/images/circle-filled.png";
       image_status_in_progress  = "assets/images/circle-unfilled.png";
       image_status_complete = "assets/images/circle-unfilled.png";
     }
     else if (working_status == "Completed"){

       image_status_request = "assets/images/circle-filled.png";
       image_status_accept = "assets/images/circle-filled.png";
       image_status_in_progress  = "assets/images/circle-filled.png";
       image_status_complete = "assets/images/circle-filled.png";
     }
     else{
       image_status_request = "assets/images/circle-filled.png";
       image_status_accept = "assets/images/circle-unfilled.png";
       image_status_in_progress  = "assets/images/circle-unfilled.png";
       image_status_complete = "assets/images/circle-unfilled.png";
     }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 121, 204, 1),
        title: Text(title_name!=null?title_name: ""),
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
new Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
                new Container(
                  color: Color.fromRGBO(248, 248, 248, 1),
                  child:Row(

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
                                        width: 70.0,
                                        height: 70.0,

                                        child: _image == null ? Image.asset('assets/images/logo_img.png') : Image.file(_image),),

                                    ],
                                  ),

                                ]),onPressed: (){

                          },
                          ),
                        ],),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                      Align(

                        alignment: FractionalOffset.topLeft,
                        child:Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,

                                child:
                                Text("Your cleaner",style: TextStyle(color: Color.fromRGBO(176, 175, 175, 1), fontSize: 9),textAlign: TextAlign.start,),),

                              Align(
                                alignment: Alignment.topLeft,

                          child:
                                Text("",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1), fontSize: 14),textAlign: TextAlign.start,),),

                            ],
                          ),),
                      ),
                    ],),
                      Container(
                        color: Color.fromRGBO(248, 248, 248, 1),
                        padding: EdgeInsets.only(left: 50),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                            IconButton(
                                              icon: new Icon(Icons.favorite, color: Color.fromRGBO(248, 248, 248, 1)),

                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: new Icon(Icons.phone, color: Color.fromRGBO(125, 121, 204, 1)),

                                              onPressed: () =>   launch("tel:+918872637757")),

                                          ],
                                        ),

                                      ]),onPressed: (){

                                },
                                ),
                              ],),


                          ],),)
                    ],),),

],),
                Divider(color:Colors.grey,height:1),
                new Container(
                  child:Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 10),
                        child:Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Your Selected Item Details',
                            style: TextStyle(fontSize:14,color: Color.fromRGBO(81, 92, 111, 1,)),

                          ),
                        ),),
                    ],
                  ),
                ),
                new Container(
padding: EdgeInsets.only(left:10,right: 10),
                  child: Card(

                    color: Color.fromRGBO(242, 242, 242, 10),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Column(

                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                          child:Align(
                            alignment: FractionalOffset.topLeft,
                            child: Text(
                                Car_type_headline!=null?Car_type_headline: "",
                              style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1).withOpacity(0.7),fontSize: 13),

                            ),
                          ),),

                        Container(


                          child: Row(
                            children: <Widget>[

                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                  child:Row(

//mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[

                                      Icon(Icons.check_box,color: Color.fromRGBO(125, 121, 204, 1),),
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(5, 5, 10, 0),
                                          child:
                                          Text(booking_type!=null?booking_type: "",
                                            style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 12),textAlign: TextAlign.justify,)
                                      ),

                                    ],
                                  )
                              )


                            ],
                          ),
                        ),]),

                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 15, 0),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                 Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                  Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),

                                    child:
                                    Text("Date",style: TextStyle(color: Color.fromRGBO(125, 121, 204, 1), fontSize:10),textAlign: TextAlign.start,),),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 3, 15, 0),

                                    child:
                                    Text("Time",style: TextStyle(color: Color.fromRGBO(125, 121, 204, 1), fontSize: 10),textAlign: TextAlign.start,),),


                                    ]), Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[

                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                              child:
                                              Text(booking_date!=null?booking_date: "",style: TextStyle(color: Color.fromRGBO(125, 121, 204, 1), fontSize:10),textAlign: TextAlign.start,),),

                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 3, 15, 0),
                                              child:
                                              Text(booking_time!=null?booking_time: "",style: TextStyle(color: Color.fromRGBO(125, 121, 204, 1), fontSize:10),textAlign: TextAlign.start,),),

                                          ])
                                    ]),
                                ],
                              ),)
                        ]),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child:Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              Valter_type_headline!=null?Valter_type_headline: "",
                              style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1).withOpacity(0.7),fontSize: 13),

                            ),
                          ),),
                        Container(

                          child: Row(

                            children: <Widget>[

                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                  child:Row(

//mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[

                                      Icon(Icons.check_box,color: Color.fromRGBO(125, 121, 204, 1),),
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(5, 5, 10, 0),
                                          child:
                                          Text(valter_type!=null?valter_type: "",
                                            style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1) ,fontSize: 12),textAlign: TextAlign.justify,)
                                      ),

                                    ],
                                  )
                              )

                            ],
                          ),
                        ),
                       Padding(
                         padding: EdgeInsets.only(top:8),
                        child:Divider(color:Colors.grey,height:1),),
                        Container(

                          child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                          Padding(
                          padding: EdgeInsets.only(left:10),
                          child:
                              Text(
                                  'Total ',
                                  style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                  textAlign: TextAlign.start
                              ),),
                              new Container(
                                alignment: Alignment.centerRight,
                                height:40,
                                width:120,
                                padding: EdgeInsets.only(left:20.0),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 8.0,top: 8.0,bottom: 8.0),
                                                child:   Text(
                                                    booking_price!=null?booking_price: "",
                                                    style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                                    textAlign: TextAlign.start
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                new Container(
                  child:Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 10),
                        child:Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Tracking History',
                            style: TextStyle(color: Colors.black,fontSize: 17),

                          ),
                        ),),
                    ],
                  ),
                ),
                new Container(


                  child: Card(

                    child:Padding(
                      padding:EdgeInsets.all(10) ,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Column(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child:Text("Requested",style: TextStyle(color: Colors.black,fontWeight:FontWeight.normal, fontSize: 14,fontFamily:"assets/fonts/Novarese-Regular.ttf")
                                    ,)),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,

                                    children: [
                                      Image.asset(image_status_request,height: 18,width: 18,),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(8, 3, 0, 0),
                                        child:Image.asset("assets/images/circle-filled.png",height: 8,width: 8,),),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(8, 3, 0, 0),
                                        child:Image.asset("assets/images/circle-filled.png",height: 5,width: 5,),),
                              ])),
                            ]),
                        Column(
                            children: <Widget>[

                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child:Text("Accepted",style: TextStyle(color: Colors.black,fontWeight:FontWeight.normal, fontSize: 14,fontFamily:"assets/fonts/Novarese-Regular.ttf")
                                    ,)),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Image.asset(image_status_accept,height: 18,width: 18,),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(8, 3, 0, 0),
                                          child:Image.asset("assets/images/circle-filled.png",height: 8,width: 8,),),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(8, 3, 0, 0),
                                          child:Image.asset("assets/images/circle-filled.png",height: 5,width: 5,),),
                                      ])),
                            ]),
                        Column(
                            children: <Widget>[

                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child:Text("In Progress",style: TextStyle(color: Colors.black,fontWeight:FontWeight.normal, fontSize: 14,fontFamily:"assets/fonts/Novarese-Regular.ttf")
                                    ,)),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Image.asset(image_status_in_progress,height: 18,width: 18,),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(8, 3, 0, 0),
                                          child:Image.asset("assets/images/circle-filled.png",height: 8,width: 8,),),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(8, 3, 0, 0),
                                          child:Image.asset("assets/images/circle-filled.png",height: 5,width: 5,),),
                                      ])),
                            ]),
                        Column(
                            children: <Widget>[

                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child:Text("Completed",style: TextStyle(color: Colors.black,fontWeight:FontWeight.normal, fontSize: 14,fontFamily:"assets/fonts/Novarese-Regular.ttf")
                                    ,)),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Image.asset(image_status_complete,height: 18,width: 18,),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(8, 3, 0, 0),
                                          child:Image.asset("assets/images/circle-filled.png",height: 8,width: 8,),),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(8, 3, 0, 0),
                                          child:Image.asset("assets/images/circle-filled.png",height: 5,width: 5,),),
                                      ])),
                            ]),



                      ],
                    ),)
                  ),
                ),
              ],),



          ],

        ),),




    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Payment()),
    );
  }

}
