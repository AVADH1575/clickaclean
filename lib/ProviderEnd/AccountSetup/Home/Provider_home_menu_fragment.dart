import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/NotificationHistory/ProviderNotificationHistory.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/booking_history/booking_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class ProviderHomeMenu extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
  return _ProviderHomeMenu();
  }
  }
  class _ProviderHomeMenu extends State<ProviderHomeMenu> {
    final Map<String, Marker> _markers = {};
    var currentLocation;
    double lat,long;
    String Full_address,Accept_status;
    String PROVIDER_API_KEY,User_service_type= "",USER_Address = "",User_Order_id= "";
    String TOP_TITLE= "";
    SharedPreferences myPrefs;
    List Time_data_list;
    List PROFILE_DATA;

    String Post_Status_String= "START", VALUE_STATUS_STRING = "", RESPONSE_MESSAGE = "";
    Map TimeData;

    bool viewVisible = false ;
    void showWidget(){
      setState(() {
        viewVisible = true ;
      });
    }

    void hideWidget(){
      setState(() {
        viewVisible = false ;
      });
    }


    Future<void> getData() async {
       myPrefs = await SharedPreferences.getInstance();


      if(myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_SERVICE_TYPE).toString() == "1"){
        TOP_TITLE = "Domestic Cleaner";
      }
      else{
        TOP_TITLE = "Car Velter";
      }
    }

    void _getLocation() async {
      currentLocation = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      final coordinates = new Coordinates(currentLocation.latitude, currentLocation.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      Full_address = first.addressLine;
      print("===current address===== "+Full_address);


      setState(() {
        _markers.clear();
        lat = currentLocation.latitude;
        long = currentLocation.longitude;

        final marker = Marker(
          markerId: MarkerId("curr_loc"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          infoWindow: InfoWindow(title: Full_address!= null ? Full_address: ""),
        );
        _markers["Current Location"] = marker;
      });
    }
    Map<String, double> _startLocation;
    Map<String, double> _currentLocation;

    bool _permission = false;
    String error;

    // Platform messages are asynchronous, so we initialize in an async method.
    initPlatformState() async {
      Map<String, double> location;
      // Platform messages may fail, so we use a try/catch PlatformException.

      try {
        _permission = await currentLocation.
        hasPermission();
        location = await currentLocation.getLocation();


        error = null;
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          error = 'Permission denied';
        } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          error = 'Permission denied - please ask the user to enable it from the app settings';
        }

        location = null;
      }

      setState(() {
        _startLocation = location;
      });

    }

    Future<dynamic> getDetailData() async {
      //GET_USER_PROFILE_URL
      myPrefs = await SharedPreferences.getInstance();

      http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_CHECK_JOB_ACCEPTED, headers: {
        'x-api-key': myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY),
      });

      var reSPONSE = json.decode(response.body);
      print("===provider==="+reSPONSE.toString());
      print("===checkstatus data==="+reSPONSE["status"].toString());
      Accept_status = reSPONSE["status"].toString();
      print("=======provider_data++++++"+reSPONSE["data"]["id"].toString());
      USER_Address = reSPONSE["data"]["address"].toString();

      if (reSPONSE["data"]["service_type"].toString() == "1") {
        User_service_type = "Domestic Cleaner";

      }
      else {
        User_service_type = "Car Velter";
      }
      User_Order_id = reSPONSE["data"]["id"].toString();
if (reSPONSE["data"]["id"] == null){
  print("=======check if====");
}
else{
  print("=======check====");


}

      setState(() {
        CheckStatusApi();
      });

    }
   Future<void> CheckStatusApi()  async {
      //GET_USER_PROFILE_URL

      print("====apikey");

      http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_CHECK_JOB_STATUS+User_Order_id, headers: {
        'x-api-key': myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY),
      });

      var reSPONSE = json.decode(response.body);
      print("===STATUS RESPOSNSE==="+reSPONSE.toString());
      print("===STATUS PRINT==="+reSPONSE["status"].toString());
      RESPONSE_MESSAGE = reSPONSE["message"].toString();
     if( RESPONSE_MESSAGE == "Job is Blank") {
       Post_Status_String = "START";

       setState(() {

       });
     }

    }
    Future Post_JOB_API() async {
      myPrefs = await SharedPreferences.getInstance();
      PROVIDER_API_KEY = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);
      if(RESPONSE_MESSAGE == "Job is Blank") {
        Post_Status_String = "START";


        var client = new http.Client();

        try {
          var response = await client.post(
              APPURLS_PROVIDER.POST_PROVIDER_JOB_POST_API,
              headers: {"x-api-key": myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY)
              },
              body: {
                'id': User_Order_id,
                'status': "Ongoing",

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
                print("=====hit for ongoing=====");
                Post_Status_String = "COMPLETE";
                showWidget();
                CheckStatusApi();
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
      if(RESPONSE_MESSAGE == "Job is Ongoing") {



        var client = new http.Client();

        try {
          var response = await client.post(
              APPURLS_PROVIDER.POST_PROVIDER_JOB_POST_API,
              headers: {"x-api-key": myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY)
              },
              body: {
                'id': User_Order_id,
                'status': "Completed",

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
                print("=====hit complete=====");
                setState(() {
                  getDetailData();
                });

               // Accept_status = "true";
                //////////////

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
      else{

      }


    }

    @override
  void initState() {
    // TODO: implement initState
     // _child = RippleIndicator("Geting Location");
    super.initState();
    _getLocation();
    initPlatformState();
    getData();
    getDetailData();

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title:
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
        Flexible(
              child:Column(

            crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
            children: [

          Container(
          padding: EdgeInsets.only(left: 30),
            child:
              Text(
                TOP_TITLE,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),),
              Padding(padding: EdgeInsets.only(top: 5),),


         Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Container(
                  height: 16,
                  width: 16,

                  alignment: Alignment.topLeft,
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage('assets/images/location_icon_white.png'),
                        fit: BoxFit.cover,
                      )
                  )

              ),),
            Flexible(
                child:  Container(
                    child: Text(
                      Full_address!= null ? Full_address: "",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )))
          ],)



            ]))])

          ,backgroundColor: Color.fromRGBO(241, 123, 72, 1),   actions: <Widget>[
            // action button
            IconButton(icon: Icon(Icons.notifications,color: Colors.white,),onPressed: (){
              _navigateToNextScreen(context);
            },)

          ],),
        body: SafeArea(

child:SingleChildScrollView(
          child:
           Accept_status == "true"?
           Column(

             children: <Widget>[

               lat == null || long == null
                   ?Container(
                 height: MediaQuery.of(context).size.height,):
               Container(
                 height: MediaQuery.of(context).size.height,
                 width: MediaQuery.of(context).size.width,
                 child:GoogleMap(
                   mapType: MapType.normal,
                   myLocationButtonEnabled: true,
                   myLocationEnabled: true,
                   initialCameraPosition: CameraPosition(
                     target: LatLng(lat ?? 0, long ?? 0),
                     zoom: 19,
                   ),
                   markers: _markers.values.toSet(),
                 ),
               ),
             ],
           )
               :
           Column(

             children: <Widget>[

               lat == null || long == null
                   ?Container(

                 ):
               Container(


                 child:Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                 Container(

                 height: MediaQuery.of(context).size.height/2,
                child:GoogleMap(
                   mapType: MapType.normal,
                   myLocationButtonEnabled: true,
                   myLocationEnabled: true,
                   initialCameraPosition: CameraPosition(
                     target: LatLng(lat ?? 0, long ?? 0),
                     zoom: 19,
                   ),
                   markers: _markers.values.toSet(),
                 )),
Container(

color: Color.fromRGBO(241, 123, 72, 1),
                         width: MediaQuery.of(context).size.width,
//              height: config.App(context).appHeight(55),
                         child: Form(

                           child: Column(

                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.center,

                             children: <Widget>[

                               Container(
                                 color: Color.fromRGBO(241, 123, 72, 1),
                                 child:Row(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: <Widget>[
                                     Column(

                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: <Widget>[


                                         Container(

                                             margin: EdgeInsets.fromLTRB(0, 30, 5, 0),
                                                     width: 100.0,
                                                         height: 100.0,
                                                         child:  Image(
                                                           image: AssetImage("assets/images/icon_logo.png"),

                                                         )

                                                 ),



                                       ],),
                                     Container(

                                       alignment: FractionalOffset.topLeft,
                                       child:Padding(
                                         padding: EdgeInsets.fromLTRB(0, 22, 0, 0),

                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: <Widget>[



                                               Container(
                                                 padding: EdgeInsets.fromLTRB(6, 8, 0, 0),
                                                 child:Text(User_service_type!=null?User_service_type: "",style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.start,),
                                               ),

                                            Container(
                                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),

                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,

                                                children: <Widget>[
                                                  Icon(Icons.location_on,color: Colors.white,),
                                             Container(
                                               width:230,
                                                 child: Text(USER_Address!=null?USER_Address: "",style: TextStyle(color: Colors.white, fontSize: 13),),
                                             ),
]                                            )),
                                             Container(
                                               padding: EdgeInsets.fromLTRB(6, 8, 0, 0),
                                               child:Text("Order ID : # ${User_Order_id!=null?User_Order_id: ""}",style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.start,),),




                                           ],
                                         ),),

                                     ),



                                   ],),),
  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
                               Container(
                                 height: 102,
                                 alignment: FractionalOffset.center,
                                 padding: EdgeInsets.fromLTRB(0, 8, 0, 25),
                                 child:FlatButton(

                                   child:Container(
                                     width: 125,
                                     height: 43,
                                     alignment: FractionalOffset.center,
                                     decoration: new BoxDecoration(
                                       borderRadius: BorderRadius.circular(5.0),
                                       color:Colors.white,
                                     )
                                     ,

                                     child: Text(Post_Status_String,style: TextStyle(fontSize: 16,color:Color.fromRGBO(241, 123, 72, 1))),
                                   ),
                                   onPressed: (){
                                     Post_JOB_API();
                                   },
                                 ),

                               ),

  Visibility(
    visible: viewVisible,
    child: Container(
    height: 102,
    alignment: FractionalOffset.center,
    padding: EdgeInsets.fromLTRB(0, 8, 0, 25),
    child:FlatButton(

      child:Container(
        width: 125,
        height: 43,
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color:Colors.white,
        )
        ,

        child: Text("CANCEL",style: TextStyle(fontSize: 16,color:Color.fromRGBO(241, 123, 72, 1))),
      ),
    ),

  ),)])




                             ],
                           ),
                         ),
                       ),




                   ])
               ),
             ],


          ),

        ),),
      ),
    );

  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProviderNotificationHistory()),
    );
  }
}