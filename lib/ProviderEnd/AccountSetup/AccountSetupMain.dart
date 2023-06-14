import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_first.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BankDetails/BankDetailFirst.dart';
import 'Home/ChooseProfessionProvider.dart';
import 'Home/ProviderHomeMenuTab.dart';
import 'VerifyAccount/verify_identity_first.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AccountSetupMAIN extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountSetupMAINState();
  }
}
class _AccountSetupMAINState extends State<AccountSetupMAIN> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   String value = "";
   String check_personal_info,check_bank_detail_info,check_verify_document;
  SharedPreferences myPrefs;
  Map Personal_info_data;
  Map BankDetail_Data;
  Map Verify_document_Data;

  List PERSONAL_INFO_LIST_DATA;
  List BANK_INFO_LIST_DATA;
  List VERIFY_DOCUMENT_LIST_DATA;
  LatLng _center ;
  Position currentLocation;
  double lat, long;

  String PROVIDER_API_KEY;

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

        print("POST_PROVIDER_ServiceProviderLatLogUpdate status: ${response.statusCode}");
        print("POST_PROVIDER_ServiceProviderLatLog body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {

            print("-====sucxcess+lat ");
          }

          else {
            print("POST_PROVIDER_Service else: ${response.statusCode}");
          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }
  Future<dynamic> getPersonalData() async {

    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    PROVIDER_API_KEY = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);

    http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_PERSONAL_INFORMATION_STATUS_CHECK, headers: {
      'x-api-key': PROVIDER_API_KEY,
    });


    Personal_info_data = json.decode(response.body);
    print("===========personal_info_data===="+Personal_info_data.toString());
    setState(() {
      PERSONAL_INFO_LIST_DATA = Personal_info_data["data"];
      print("===========personal_info_list===="+PERSONAL_INFO_LIST_DATA.toString());
      check_personal_info =  PERSONAL_INFO_LIST_DATA[0]["status"]!=null? PERSONAL_INFO_LIST_DATA[0]["status"]: "0";
      print("===check_personal_info data==="+check_personal_info);

    });
  }

  Future<dynamic> getBankDetailData() async {

    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    PROVIDER_API_KEY = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);

    http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_BANK_DETAILS_STATUS_CHECK, headers: {
      'x-api-key': PROVIDER_API_KEY,
    });


    BankDetail_Data = json.decode(response.body);
    print("===BANK_Details_DATA data==="+BankDetail_Data.toString());
    setState(() {
      BANK_INFO_LIST_DATA = BankDetail_Data["data"];
      print("===BANK_INFO_LIST_DATA data==="+BANK_INFO_LIST_DATA.toString());
      check_bank_detail_info =  BANK_INFO_LIST_DATA[0]["status"]!=null? BANK_INFO_LIST_DATA[0]["status"]: "0";
      print("===check_bank_detail_info data==="+check_bank_detail_info);

    });
  }

  Future<dynamic> getVerifyData() async {

    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    PROVIDER_API_KEY = myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY);

    http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_VERIFY_DOCUMENT_STATUS_CHECK, headers: {
      'x-api-key': PROVIDER_API_KEY,
    });


    Verify_document_Data = json.decode(response.body);
    print("===Verify_document_Data data==="+Verify_document_Data.toString());
    setState(() {
      VERIFY_DOCUMENT_LIST_DATA = Verify_document_Data["data"];
      print("===VERIFY_DOCUMENT_LIST_DATA data==="+VERIFY_DOCUMENT_LIST_DATA.toString());
      check_verify_document =  VERIFY_DOCUMENT_LIST_DATA[0]["status"]!=null? VERIFY_DOCUMENT_LIST_DATA[0]["status"]: "0";
      print("===check_verify_document data==="+check_verify_document);

    });
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPersonalData();
    getBankDetailData();
    getVerifyData();
    getUserLocation();


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("Account Setup"), backgroundColor: Color.fromRGBO(241, 123, 72, 1), leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            _navigateToNextScreenBack(context);
          }
        ),),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(0, 33, 0, 0),
                    child: Text(
                      'Setup your identity in \n3 simple steps',textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(33, 32, 32, 1), fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 21),
                    )
                ),

                    check_personal_info == "1"
                    ?
                Container(
                    height: 49,

                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin:  EdgeInsets.fromLTRB(0, 50, 10, 0),
                    child: RaisedButton(

                      child: Container(
                        child:
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.perm_identity,color: Colors.white,),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                        child:Text("Personal Information",style: TextStyle(color: Colors.white, fontSize: 16)
                                          ,))
                                  ]),
                              Icon(Icons.check_circle_outline,color: Colors.white,)

                            ],
                          ),),

                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Colors.white,
                      color: Color.fromRGBO(241, 123, 72, 1),
                      splashColor: Color.fromRGBO(0, 0, 0, 0.16),

                      onPressed: () async {

                        //_navigateToNextScreen(context);


                      },
                    )):

                Container(
                    height: 49,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin:  EdgeInsets.fromLTRB(0, 50, 10, 0),
                    child: RaisedButton(

                      child: Container(
                        child:
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SvgPicture.asset('assets/images/p_user_icon.svg',height: 20,width: 20,color: Color.fromRGBO(241, 123, 72, 1) ,),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                        child:Text("Personal Information",style: TextStyle(color: Colors.black, fontSize: 16)
                                          ,))
                                  ]),
                              SvgPicture.asset('assets/images/next-icon-orange.svg',height: 20,width: 20,),
                              //Image.asset('assets/images/p_orange_next_icon.png',height: 20,width: 20,color: Color.fromRGBO(241, 123, 72, 1) ,),


                            ],
                          ),),

                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Colors.white,
                      color: Color.fromRGBO(248, 248, 248, 1),
                      splashColor: Color.fromRGBO(0, 0, 0, 0.16),

                      onPressed: () async {
                        SharedPreferences myPrefs = await SharedPreferences.getInstance();

                        _navigateToNextScreen(context);


                      },
                    )),
                check_verify_document == "1"  ?
                Container(
                    height: 49,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin:  EdgeInsets.fromLTRB(0, 19, 10, 0),
                    child: RaisedButton(


                      child: Container(
                        child:
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.verified_user,color: Colors.white,),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                        child:Text("Verify your identity",style: TextStyle(color: Colors.white, fontSize: 16),),)
                                  ]),

                              Icon(Icons.check_circle_outline,color: Colors.white,)

                            ],
                          ),
                        ),

                      ),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Colors.white,
                      color: Color.fromRGBO(241, 123, 72, 1),

                      onPressed: () {

                      },
                    )):
                Container(
                    height: 49,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin:  EdgeInsets.fromLTRB(0, 19, 10, 0),
                    child: RaisedButton(


                      child: Container(
                        child:
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.verified_user,color: Color.fromRGBO(241, 123, 72, 1) ,),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child:Text("Verify your identity",style: TextStyle(color: Colors.black, fontSize: 16),),)
                                  ]),


                              SvgPicture.asset('assets/images/next-icon-orange.svg',height: 20,width: 20,),


                            ],
                          ),
                        ),

                      ),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Colors.white,
                      color: Color.fromRGBO(248, 248, 248, 1),

                      onPressed: () {
                        if(check_personal_info == "0"){

                        }
                        else {
                          _navigateToNextScreen1(context);
                        }
                      },
                    )),


                  check_bank_detail_info == "1"
                    ?  Container(
                    height: 49,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin:  EdgeInsets.fromLTRB(0, 19, 10, 0),
                    child: RaisedButton(


                      child: Container(
                        child:
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.account_balance,color: Colors.white,),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text("Provide bank details",style: TextStyle(color: Colors.white, fontSize: 16),),)
                                  ]),

                              Icon(Icons.check_circle_outline,color: Colors.white,)
                            ],
                          ),),
                      ),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Colors.white,
                      color: Color.fromRGBO(241, 123, 72, 1),

                      onPressed: () {

                      },
                    ))

               : Container(
                    height: 49,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin:  EdgeInsets.fromLTRB(0, 19, 10, 0),
                    child: RaisedButton(

                      child: Container(
                        child:
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.account_balance,color: Color.fromRGBO(241, 123, 72, 1) ,),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text("Provide bank details",style: TextStyle(color: Colors.black, fontSize: 16),),)
                                  ]),

                              SvgPicture.asset('assets/images/next-icon-orange.svg',height: 20,width: 20,),
                            ],
                          ),),

                      ),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Colors.white,
                      color: Color.fromRGBO(248, 248, 248, 1),

                      onPressed: () {
                        if(check_personal_info == "0"){

                        }
                        else {
                          _navigateToNextScreen2(context);
                        }

                      },
                    )),

                Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin:  EdgeInsets.fromLTRB(0, 100, 10, 0),

                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Colors.white,
                      color: Color.fromRGBO(241, 123, 72, 1),
                      child: Text('COMPLETE',style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,)),
                      onPressed: () {


                        if(check_personal_info == "1" && check_verify_document == '1'){
                          _navigateToNextScreen3(context);

                        }
                        else {
                          Fluttertoast.showToast(
                              msg: "Please fill your account details step by step",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1
                          );
                        }

                      },
                    )),
              ],
            )));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PersonalInformationFirst()),
    );
  }
  void _navigateToNextScreen1(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerifyIdentyFirst()),
    );
  }

  void _navigateToNextScreen2(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BankDetailFirst()),
    );
  }
  void _navigateToNextScreen3(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProviderHomeScreenTab()),
    );
  }
  void _navigateToNextScreenBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseProfessionProvider()),
    );
  }
}