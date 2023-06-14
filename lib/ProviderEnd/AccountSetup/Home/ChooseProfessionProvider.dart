
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/NotificationHistory/ProviderNotificationHistory.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_first.dart';
import 'package:click_a_clean/UserEnd/ImagePickerExample.dart';
import 'package:click_a_clean/UserEnd/ImagePickerScreen.dart';
import 'package:click_a_clean/UserEnd/camera_screen.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../AccountSetupMain.dart';


class ChooseProfessionProvider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChooseProfessionProvider();
  }
}
class _ChooseProfessionProvider extends State<ChooseProfessionProvider> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String PROVIDER_API_KEY;
  LatLng _center ;
  Position currentLocation;
  double lat, long;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStoreData();
    getUserLocation();


  }
  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    lat = currentLocation.latitude;
    long = currentLocation.longitude;
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
      print("====lat==="+currentLocation.latitude.toString() + "===long"+ currentLocation.longitude.toString());
      post_DOMESTIC_BOOKING();
    });
    print('center $_center');
  }
  Future post_DOMESTIC_BOOKING() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_PROVIDER.POST_PROVIDER_ServiceProviderLatLogUpdate,
          headers: {"x-api-key": myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY)
          },
          body: {
            'lat': lat.toString(),
            'log': long.toString(),
            'name': myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_PROVIDER_NAME_GLOBAL)

          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("price status: ${response.statusCode}");
        print("price body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {


            print("-====sucxcess+lat ");
          }

          else {
            print("price_ListResponse else: ${response.statusCode}");
          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: Text("Account Setup"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),
        body:  Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('assets/images/home_option.png'),
                      fit: BoxFit.cover
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[

                          Container(
                            height: 49,
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            margin:  EdgeInsets.fromLTRB(0, 35, 0, 0),


                            child: Container(
                              child:
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

                                    Text("text",style: TextStyle(color: Colors.transparent, fontSize: 16),),
                                    Text("Please Select Your Service",style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Color.fromRGBO(96, 96, 96, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                                    IconButton(icon: Icon(Icons.notifications_none,color:  Color.fromRGBO(241, 123, 72, 1)) , onPressed: (){
                                      _navigateToNextScreen(context);
                                    })
                                    //Image.asset('assets/images/p_orange_next_icon.png',height: 20,width: 20,color: Color.fromRGBO(241, 123, 72, 1) ,),
                                  ],
                                ),),
                            ),

                          ),

                          Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.fromLTRB(0, 33, 0, 0),
                              child:
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Domestic \n Cleaner',textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Color.fromRGBO(125, 121, 204, 1),
                                          fontSize: 30),
                                    ),
                                    RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)),
                                        textColor: Colors.white,
                                        color: Color.fromRGBO(125, 121, 204, 1),
                                        child: Text('Click Here'),
                                        onPressed: () async {
                                          print(nameController.text);

                                          ///////////////

                                          // ==================== working api ====================

                                          var client = new http.Client();
                                          try {
                                            var response = await client.post(
                                                APPURLS_PROVIDER
                                                    .POST_PROVIDER_SERVICE_CHOOSE,

                                                headers: {
                                                  "x-api-key": PROVIDER_API_KEY
                                                },
                                                body: {
                                                  'provider_serviceProvider': "1",
                                                }
                                            );

                                            if (response.statusCode == 200) {
                                              //enter your code

                                              print("Response status: ${response
                                                  .statusCode}");
                                              print("Response body: ${response
                                                  .body}");

                                              SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                              myPrefs.setString(STORE_PREFS_PROVIDER.PROVIDER_SERVICE_TYPE,"1");
                                              Navigator.of(
                                                  context, rootNavigator: true)
                                                  .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      AccountSetupMAIN(),
                                                  maintainState: false));

                                              final jsonData = json.decode(
                                                  response.body);
                                              if (jsonData["status"] == "true") {
                                                SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                                myPrefs.setString(STORE_PREFS_PROVIDER.PROVIDER_SERVICE_TYPE,"1");
                                                Navigator.of(
                                                    context, rootNavigator: true)
                                                    .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        AccountSetupMAIN(),
                                                    maintainState: false));
                                              }
                                            }

                                            else {
                                              Fluttertoast.showToast(
                                                  msg: "Something error occured",
                                                  toastLength: Toast
                                                      .LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIos: 1
                                              );
                                            }
                                          } on Exception catch (err) {
                                            print("Error : $err");
                                          }
                                        })
                                  ])
                          ),


                        ],
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.fromLTRB(10, 60, 0, 0),
                          child:
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Car \nValeter',textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Color.fromRGBO(241, 123, 72 ,1),

                                      fontSize: 30),
                                ),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    textColor: Colors.white,
                                    color: Color.fromRGBO(241, 123, 72 ,1),
                                    child: Text('Click Here'),
                                    onPressed: () async {
                                      //print(nameController.text);



                                      // ==================== working api ====================

                                      var client = new http.Client();
                                      try {
                                        var response = await client.post(
                                            APPURLS_PROVIDER
                                                .POST_PROVIDER_SERVICE_CHOOSE,

                                            headers: {
                                              "x-api-key": PROVIDER_API_KEY.toString()
                                            },
                                            body: {
                                              'provider_serviceProvider': "2",
                                            }

                                        );


                                        if (response.statusCode == 200) {
                                          //enter your code

                                          print("Response status: ${response
                                              .statusCode}");
                                          print("Response body: ${response
                                              .body}");
                                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                              builder: (context) => AccountSetupMAIN(), maintainState: true));

                                          SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                          myPrefs.setString(STORE_PREFS_PROVIDER.PROVIDER_SERVICE_TYPE,"2");

                                          final jsonData = json.decode(
                                              response.body);
                                          if (jsonData["status"] == "true") {
                                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                builder: (context) => AccountSetupMAIN(), maintainState: false));

                                            SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                            myPrefs.setString(STORE_PREFS_PROVIDER.PROVIDER_SERVICE_TYPE,"2");
                                          }


                                        }
                                        else {
                                          Fluttertoast.showToast(
                                              msg: "Something error occured",
                                              toastLength: Toast
                                                  .LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIos: 1
                                          );
                                        }
                                      } on Exception catch (err) {
                                        print("Error : $err");
                                      }
                                    })


                              ])
                      ),
                      Container(
                        height: 0,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        margin:  EdgeInsets.fromLTRB(0, 100, 10, 0),

                      ),


                    ])));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProviderNotificationHistory()),
    );
  }
  getStoreData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    PROVIDER_API_KEY = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);

    print("=====check store ==="+PROVIDER_API_KEY.toString());}


}