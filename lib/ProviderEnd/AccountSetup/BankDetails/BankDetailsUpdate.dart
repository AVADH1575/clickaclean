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

class BankDetailsUpdate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BankDetailsUpdate();
  }
}
class _BankDetailsUpdate extends State<BankDetailsUpdate> {
  TextEditingController account_name_field = TextEditingController();
  TextEditingController bank_account_number_field = TextEditingController();
  TextEditingController confirm_bank_account_number_field = TextEditingController();
  TextEditingController ifsc_code_ = TextEditingController();

  String value = "";
  String check_bank_post_status;
  List PROFILE_DATA;
  Future<dynamic> getBankDetailData() async {
    //GET_USER_PROFILE_URL
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    http.Response response =  await http.get(APPURLS_PROVIDER.GET_PROVIDER_BANK_DETAILS, headers: {
      'x-api-key': myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY),
    });


    var reSPONSE = json.decode(response.body);
    print("===providerName data==="+reSPONSE.toString());
    check_bank_post_status = reSPONSE["status"].toString() != null ? reSPONSE["status"].toString(): "";
    print("===check_bank_post_status data==="+reSPONSE["status"].toString());
    setState(() {
      PROFILE_DATA = reSPONSE["data"];

      account_name_field = TextEditingController(text: PROFILE_DATA[0]["providerName"].toString() != null ? PROFILE_DATA[0]["providerName"].toString(): "");
      bank_account_number_field = TextEditingController(text: PROFILE_DATA[0]["bankAccount"].toString() != null ?  PROFILE_DATA[0]["bankAccount"].toString(): "");
      confirm_bank_account_number_field = TextEditingController(text: PROFILE_DATA[0]["confirmBankAccount"].toString() != null ?  PROFILE_DATA[0]["confirmBankAccount"].toString(): "");
      ifsc_code_ = TextEditingController(text: PROFILE_DATA[0]["IFSC"].toString() != null ? PROFILE_DATA[0]["IFSC"].toString(): "");

    });

  }
  Future bank_post_api_hit_new() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_PROVIDER.POST_PROVIDER_BANK_DETAIL_URL,
          headers: {"x-api-key": myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY).toString()
          },
          body: {
            'providerName': account_name_field.text,
            'bankAccount': bank_account_number_field.text,
            'confirmBankAccount': confirm_bank_account_number_field.text,
            'IFSC':  ifsc_code_.text,
            'service_id': myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_SERVICE_TYPE).toString(),

          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("TIME_DTAE_ListResponse status: ${response.statusCode}");
        print("TIME_DTAEResponse body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {

            myPrefs.setString(STORE_PREFS_PROVIDER.COMPLETE_PERSONAL_INFORMATION_STATUS,"Complete");
            Navigator.pop(context);

          }

          else {
            print("TIME_DTAE_ListResponse else: ${response.statusCode}");
          }
        });

      }
    } on Exception catch (err) {
      print("Error : $err");
    }
  }

  Future bank_post_api_hit() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_PROVIDER.POST_PROVIDER_BANK_DETAILS_UPDATE,
          headers: {"x-api-key": myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY).toString()
          },
          body: {
            'providerName': account_name_field.text,
            'bankAccount': bank_account_number_field.text,
            'confirmBankAccount': confirm_bank_account_number_field.text,
            'IFSC':  ifsc_code_.text,

          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("TIME_DTAE_ListResponse status: ${response.statusCode}");
        print("TIME_DTAEResponse body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {


            Navigator.pop(context);

          }

          else {
            print("TIME_DTAE_ListResponse else: ${response.statusCode}");
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
    getBankDetailData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bank Details"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

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
                            padding:  EdgeInsets.fromLTRB(23, 21, 23, 0),
                            child:
                            Text("Name (as registered in Bank)",
                              style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                        ),
                      ),
                      Padding(
                          padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                          child: TextField(
                            controller: account_name_field,
                            style: TextStyle(
                              fontSize: 14.0,

                            ),
                            cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                            decoration: InputDecoration(
                              hintText: 'Name',

                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                              ),),

                          ))
                      ,
                      Align(
                        alignment: Alignment.topLeft,
                        child:Padding(
                            padding:  EdgeInsets.fromLTRB(23, 21, 23, 0),
                            child:Text('Bank Account Number',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14))
                        ),),
                      Padding(
                          padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                          child: TextField(
                            controller: bank_account_number_field,
                            style: TextStyle(
                              fontSize: 14.0,

                            ),
                            cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                            decoration: InputDecoration(
                              hintText: 'Bank Account Number',

                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                              ),),

                          ))
                      ,

                      Align(
                        alignment: Alignment.topLeft,
                        child:Padding(
                            padding:  EdgeInsets.fromLTRB(23, 21, 23, 0),
                            child:Text('Confirm Bank Account Number',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                        ),),
                      Padding(
                          padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                          child: TextField(
                            controller: confirm_bank_account_number_field,
                            style: TextStyle(
                              fontSize: 14.0,

                            ),

                            cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                            decoration: InputDecoration(

                              hintText: 'Confirm Bank Account Number',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                              ),),

                          ))
                      ,

                      Align(
                        alignment: Alignment.topLeft,
                        child:Padding(
                            padding:  EdgeInsets.fromLTRB(23, 21, 23, 0),
                            child:Text('IFSC Code',style: TextStyle(color: Color.fromRGBO(241, 123, 72, 1) ,fontSize: 14),)
                        ),),
                      Padding(
                          padding:  EdgeInsets.fromLTRB(23, 0, 23, 0),
                          child: TextField(
                            controller: ifsc_code_,
                            style: TextStyle(
                              fontSize: 14.0,

                            ),

                            cursorColor:  Color.fromRGBO(241, 123, 72, 1),
                            decoration: InputDecoration(

                              hintText: 'IFSC Code',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(241, 123, 72, 1)),
                              ),),

                          ))

                    ]),



              ],)),



      ),
      bottomNavigationBar: new Container(


        child: Container(

          color: Color.fromRGBO(241, 123, 72, 1),
          height: 52,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: FractionalOffset.bottomRight,
                child: FlatButton(
                  onPressed: (){
                    if(check_bank_post_status == "false"){
                      bank_post_api_hit_new();
                    }
                    else{
                      bank_post_api_hit();
                    }
                  },
                  child: Row(

                    children: <Widget>[
                      Row(

                        children: <Widget>[
                          FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: <Widget>[


                                ],)
                          ),
                        ],),


//Image.asset('assets/images/p_orange_next_icon.png',height: 20,width: 20,color: Color.fromRGBO(241, 123, 72, 1) ,),


                    ],
                  ),
                ),),
              Align(
                alignment: FractionalOffset.bottomRight,
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: FractionalOffset.center,
                            child:FlatButton(
                                onPressed: () {


                                  if(check_bank_post_status == "false"){
                                    bank_post_api_hit_new();
                                  }
                                  else{
                                    bank_post_api_hit();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Update",style: TextStyle(color: Colors.white,fontSize: 16)),
                                    Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                  ],)
                            ),),
                        ],),

                    ],
                  ),
                ),),

            ],),
        ),
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