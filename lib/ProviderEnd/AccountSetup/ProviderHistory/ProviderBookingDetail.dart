import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/AccountSetupMain.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/Home/ProviderHomeMenuTab.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_second.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/Profile/provider_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProviderBookingDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProviderBookingDetail();
  }
}
class _ProviderBookingDetail extends State<ProviderBookingDetail> {
String service_type,booking_time,customer_address,phone_number,order_id,key_collection_instruction,gate_code_instructions,booking_price;

  String value = "";
  String check_bank_post_status;
  List PROFILE_DATA;
  SharedPreferences myPrefs;
  Future<dynamic> getBankDetailData() async {
    //GET_USER_PROFILE_URL
     myPrefs = await SharedPreferences.getInstance();
print("========id===apikey==="+myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_ONGOING_BOOKING_DETAIL).toString()+myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY));
    http.Response response =  await http.get(APPURLS_PROVIDER.GET_BOOKING_DETAIL_URL+myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_ONGOING_BOOKING_DETAIL).toString(), headers: {
      'x-api-key': myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY),
    });


    var reSPONSE = json.decode(response.body);
    print("===providerName data==="+reSPONSE.toString());
    check_bank_post_status = reSPONSE["status"].toString() != null ? reSPONSE["status"].toString(): "";
    print("===check_bank_post_status data==="+reSPONSE["status"].toString());
    setState(() {
      PROFILE_DATA = reSPONSE["data"];
      print("=======provider_data++++++"+PROFILE_DATA.toString());
if(PROFILE_DATA[0]["service_type"].toString() == "1"){
  service_type = "Domestic Cleaner";
}
else{
  service_type = "Car Velter";
      }

      booking_time =  PROFILE_DATA[0]["userDate"].toString() + " at " +  PROFILE_DATA[0]["userTime"].toString();
      customer_address =  PROFILE_DATA[0]["address"].toString() ;
      phone_number = PROFILE_DATA[0]["phone"].toString() ;
      order_id = "#"+PROFILE_DATA[0]["id"].toString();
      key_collection_instruction = PROFILE_DATA[0]["keyfile"].toString();
      gate_code_instructions = PROFILE_DATA[0]["code"].toString();
      booking_price = PROFILE_DATA[0]["price"].toString();
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBankDetailData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Leads Detail"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

      body: SafeArea(

        child:
        SingleChildScrollView(

            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[

                Column(
                    children: <Widget>[

                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding:  EdgeInsets.fromLTRB(23, 20, 23, 0),
                            child:
                            Text("SERVICE TYPE",
                              style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                        ),
                      ),
          Align(
              alignment: Alignment.topLeft,
              child:Padding(
                          padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                          child:   Text(service_type!=null?service_type: "",
                            style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1), fontSize: 14),)))
                      ,
                      Padding(
                          padding:  EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Divider(height: 1,color: Colors.grey,)),
                      Align(
                        alignment: Alignment.topLeft,
                        child:Padding(
                            padding:  EdgeInsets.fromLTRB(23, 10, 23, 0),
                            child:Text('BOOKING TIME',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14))
                        ),),
          Align(
              alignment: Alignment.topLeft,
              child:Padding(
                          padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                          child:Text(booking_time!=null?booking_time: "",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1),fontSize: 14))))
                      ,
                      Padding(
                          padding:  EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Divider(height: 1,color: Colors.grey,)),
                      Align(
                        alignment: Alignment.topLeft,
                        child:Padding(
                            padding:  EdgeInsets.fromLTRB(23, 10, 23, 0),
                            child:Text('CUSTOMER ADDRESS',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                        ),),
          Align(
              alignment: Alignment.topLeft,
              child:Padding(
                          padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                          child:Text(customer_address!=null?customer_address: "",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1), fontSize: 14))))
                      ,
                      Padding(
                          padding:  EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Divider(height: 1,color: Colors.grey,)),
                      Align(
                        alignment: Alignment.topLeft,
                        child:Padding(
                            padding:  EdgeInsets.fromLTRB(23, 10, 23, 0),
                            child:Text('PHONE NUMBER',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                        ),),
          Align(
              alignment: Alignment.topLeft,
              child:Padding(
                          padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                          child:Text(phone_number!=null?phone_number: "",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1) ,fontSize: 14)))),
                      Padding(
                          padding:  EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Divider(height: 1,color: Colors.grey,)),
                      Align(
                        alignment: Alignment.topLeft,
                        child:Padding(
                            padding:  EdgeInsets.fromLTRB(23, 10, 23, 0),
                            child:Text('ORDER ID',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                        ),),
          Align(
              alignment: Alignment.topLeft,
              child:Padding(
                          padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                          child:Text(order_id!=null?order_id: "",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1),fontSize: 14)))),
                      Padding(
                          padding:  EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Divider(height: 1,color: Colors.grey,)),
                      Align(
                        alignment: Alignment.topLeft,
                        child:Padding(
                            padding:  EdgeInsets.fromLTRB(23, 10, 23, 0),
                            child:Text('KEY COLLECTION INSTRUCTIONS',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                        ),),
                      Align(
                          alignment: Alignment.topLeft,
                          child:Padding(
                              padding:  EdgeInsets.fromLTRB(23, 2, 23, 0),
                              child:Text(key_collection_instruction!=null?key_collection_instruction: "",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1),fontSize: 14)))),
                      Padding(
                          padding:  EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Divider(height: 1,color: Colors.grey,)),
                      Align(
                        alignment: Alignment.topLeft,
                        child:Padding(
                            padding:  EdgeInsets.fromLTRB(23, 10, 23, 0),
                            child:Text('GATE CODE INSTRUCTIONS',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                        ),),

          Align(
              alignment: Alignment.topLeft,
                      child:Padding(
                          padding:  EdgeInsets.fromLTRB(23, 2, 23, 0),
                          child:Text(gate_code_instructions!=null?gate_code_instructions: "",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1),fontSize: 14)))),
                    ]),
                Padding(
                    padding:  EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Divider(height: 1,color: Colors.grey,)),
                Align(
                  alignment: Alignment.topLeft,
                  child:Padding(
                      padding:  EdgeInsets.fromLTRB(23, 10, 23, 0),
                      child:Text('BOOKING PRICE',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                  ),),

                Align(
                    alignment: Alignment.topLeft,
                    child:Padding(
                        padding:  EdgeInsets.fromLTRB(23, 2, 23, 0),
                        child:Text(booking_price!=null?booking_price: "",style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1),fontSize: 14)))),

                Padding(
                    padding:  EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Divider(height: 1,color: Colors.grey,)),


              ],)),



      ),

    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProvideProfileScreen()),
    );
  }

}