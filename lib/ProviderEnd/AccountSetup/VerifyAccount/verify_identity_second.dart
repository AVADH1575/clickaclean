import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/PersonalInformation/personal_information_third.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/VerifyAccount/verifyCountry_choose.dart';
import 'package:click_a_clean/UserEnd/home_widget.dart';
import 'package:click_a_clean/UserEnd/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'IdentityAllowCameraAccess.dart';

class VerifyIdentySecond extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerifyIdentySecond();
  }
}
class _VerifyIdentySecond extends State<VerifyIdentySecond> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  String document_type;


  Future PostDocumentType(String doc_type) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
print("=params==="+doc_type + "=-====="+myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY).toString());
    var client = new http.Client();
    try {
      var response = await client.post(
          APPURLS_PROVIDER.POST_PROVIDER_DOCUMENT_TYPE,
          headers: {"x-api-key": myPrefs.getString(STORE_PREFS_PROVIDER.PROVIDER_API_KEY).toString()
          },
          body: {
            'type': doc_type,
          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("Document Type status: ${response.statusCode}");
        print("Document Type Response body: ${response.body}");

        final jsonData = json.decode(response.body);

        setState(() {

          if (jsonData["status"] == true) {

            _navigateToNextScreen(context);

          }

          else {
            print("Document Type Response else: ${response.statusCode}");
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Identity Verification"), backgroundColor: Color.fromRGBO(241, 123, 72, 1),),

        body: SafeArea(

            child:
            Align(

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[

                    Column(
                        children: <Widget>[

                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 30, 23, 0),
                                child:
                                Text("Select a document",
                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1) ,fontSize: 21),textAlign: TextAlign.center,)
                            ),
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding:  EdgeInsets.fromLTRB(23, 9, 23, 0),
                                child:
                                Text("You will take picture of it in next step",
                                  style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1) ,fontSize: 16),textAlign: TextAlign.center,)
                            ),
                          ),
                      Padding(
                         padding:  EdgeInsets.fromLTRB(0, 38, 0, 0),
                          child:Divider(
                              color: Color.fromRGBO(0, 0, 0, 0.16)
                          ),),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child:
                            FlatButton(

                           child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset('assets/images/passport.svg',height: 18,width: 18,),
                                Padding(
                                  padding:  EdgeInsets.fromLTRB(10, 0, 0, 0),
                               child: Text(
                                    'Passport',
                                    style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 13),
                                    textAlign: TextAlign.start
                                )),],),
                                new Container(
                                ),
                                Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(241, 123, 72, 1))
                              ],
                            ),onPressed: (){
                             setState(() {
                               document_type = "Passport";
                               PostDocumentType(document_type);

                             });

                            },),
                          ),

                          Padding(
                            padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child:Divider(
                                color: Color.fromRGBO(0, 0, 0, 0.16)
                            ),),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child:
                            FlatButton(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset('assets/images/driving.svg',height: 16,width: 16,),
                                      Padding(
                                          padding:  EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          child: Text(
                                              'Driving License',
                                              style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 13),
                                              textAlign: TextAlign.start
                                          )),],),
                                  new Container(
                                  ),
                                  Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(241, 123, 72, 1))
                                ],
                              ),
                            onPressed: (){
                              setState(() {
                                document_type = "Driving License";
                                PostDocumentType(document_type);

                              });

                            },),
                          ),
                          Padding(
                            padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child:Divider(
                                color: Color.fromRGBO(0, 0, 0, 0.16)
                            ),),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child:
                            FlatButton(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      SvgPicture.asset('assets/images/national-id.svg',height: 16,width: 16,),
                                      Padding(
                                          padding:  EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          child: Text(
                                              'National ID',
                                              style: TextStyle(color: Color.fromRGBO(81, 92, 111, 1),fontSize: 13),
                                              textAlign: TextAlign.start
                                          )),],),
                                  new Container(
                                  ),
                                  Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(241, 123, 72, 1))
                                ],
                              ),onPressed: (){
                              setState(() {
                                document_type = "National Id";
                                PostDocumentType(document_type);

                              });

                            },),
                          ),

                          Padding(
                            padding:  EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child:Divider(
                                color: Color.fromRGBO(0, 0, 0, 0.16)
                            ),),
                        ]),




                  ],))));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IdentityAllowCameraAccess(type: document_type)),
    );
  }

}