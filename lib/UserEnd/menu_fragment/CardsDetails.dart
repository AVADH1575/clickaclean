import 'package:click_a_clean/ApiHit/Constants/constants.dart';
import 'package:click_a_clean/UserEnd/PaymentSection/paymentSucess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;


import 'dart:convert';

import '../UserAllProviderScreen.dart';

//import 'add_new_address.dart';

class CardsDetails extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
// TODO: implement createState
    return _CardsDetails();
  }
}

class _CardsDetails extends State<CardsDetails> {
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  bool thuVal = false;
  String service_PRICE = "";
  SharedPreferences myPrefs;
  static String secret = 'sk_test_51I8KXGIBRP251sV3jnv6eAixA5YetSZn0NjvkctwUGAuNlvjl2NH9RSmqEvtEScZeMnMRlJaVh7v6BOYk9aATzJR00i9U6hwVL';

  TextEditingController cardNumberController = new TextEditingController();
  TextEditingController expYearController = new TextEditingController();
  TextEditingController expMonthController = new TextEditingController();
  TextEditingController cvcController = new TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    StripePayment.setOptions(
        StripeOptions(publishableKey: "pk_test_6pckbCips3dpDhVKp0RH7jh4", merchantId: "Test", androidPayMode: 'test')
    );
  }
  void setError(dynamic error) {
   // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.toString())));
    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1
    );
    setState(() {
     //_error = error.toString();
     print("====errror"+error.toString());
    });
  }
  Future  getData() async {
     myPrefs = await SharedPreferences.getInstance();
     service_PRICE = myPrefs.getString(STORE_PREFS.USER_CAR_VALET_PRICE);
    print("=======key"+myPrefs.getString(STORE_PREFS.USER_API_KEY));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 121, 204, 1),
        title: Text('Credit/Debit Cards'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[


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
                              left: 25.0, right: 25.0, top: 30.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(

                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[

                                  new Text(

                                    'CARD NUMBER',
                                    style: TextStyle(

                                      fontSize: 12.0,

                                    ),
                                  ),
                                ],
                              ),

                            ],
                          )),




                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 0.0),
                                  child: new TextField(
                                    controller: cardNumberController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters:[
                                      LengthLimitingTextInputFormatter(16),
                                    ],
                                    style: TextStyle(color: Color.fromRGBO(125, 121, 204, 1)),
                                    decoration: const InputDecoration(

                                      focusedBorder: OutlineInputBorder(

                                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                                      ),
                                      hintText: "XXXX XXXX XXXX XXXX",
                                    ),

                                  ),
                                ),
                                flex: 3,
                              ),

                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 13.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child:      new Text(

                                    'EXPIRY MONTH',
                                    style: TextStyle(

                                      fontSize: 12.0,

                                    ),
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Container(
                                  child:      new Text(

                                    'EXPIRY YEAR',
                                    style: TextStyle(

                                      fontSize: 12.0,

                                    ),
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Container(

                                  child:    new Text(

                              'CVV',
                              style: TextStyle(
                              fontSize: 12.0,

                              ),
                              ),
                                ),
                                flex: 1,
                              ),
                            ],
                          )),

                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: new TextField(
                                    controller: expMonthController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters:[
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    style: TextStyle(color: Color.fromRGBO(125, 121, 204, 1)),
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                                      ),
                                      hintText: "MM",
                                    ),

                                  ),
                                ),
                                flex: 1,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: new TextField(
                                    controller: expYearController,
                                    inputFormatters:[
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    style: TextStyle(color: Color.fromRGBO(125, 121, 204, 1)),
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                                      ),
                                      hintText: "YY",
                                    ),

                                  ),
                                ),
                                flex: 1,
                              ),
                              Flexible(
                                child: new TextField(
                                  controller: cvcController,
                                  style: TextStyle(color: Color.fromRGBO(125, 121, 204, 1)),
                                  keyboardType: TextInputType.number,
                                  inputFormatters:[
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                                    ),
                                    hintText: "XXX",
                                  ),

                                ),
                                flex: 1,
                              ),
                            ],
                          )),



                      Padding(
                          padding: EdgeInsets.only(
                              top: 40.0,left:15.0, right: 25.0),
                          child: new Row(

                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Row(


                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[

                                ],
                              ),

                            ],
                          )),


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
              alignment: FractionalOffset.bottomLeft,
              child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child:FlatButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

Text(service_PRICE,style:TextStyle(color: Colors.white),)

                                ],)
                          ),),
                      ],),


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
//                              onPressed: () {
//                                //_navigateToNextScreen(context);
//                              },
                              onPressed: () {
                                final CreditCard testCard =  CreditCard(
                                    number: cardNumberController.text,
                                    expMonth: int.parse(expMonthController.text),
                                    expYear: int.parse(expYearController.text),
                                  cvc: cvcController.text
                                );
                        StripePayment.createTokenWithCard(testCard).then((
                             token) {
                           print("===========token with card detail======" +
                               token.tokenId);

                           createCharge(token.tokenId);
                         }).catchError(setError);


                                 },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Continue",style: TextStyle(color: Colors.white,fontSize: 16)),

                                  Icon(
                                      Icons.arrow_forward_ios,color: Colors.white)

                                ],

                              )

                          ),),

                      ],),


                  ],
                ),
              ),),

          ],),
      ),


    );
  }
   Future createCharge(String tokenId) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
print("=======key"+myPrefs.getString(STORE_PREFS.USER_API_KEY));

     double x = double.parse(service_PRICE);
     print("=======check====");
     double amount = x*1000;
 int price = amount.toInt();
    print(x*1000);
    var client = new http.Client();
    try {
      var response = await client.post(
          "http://35.178.249.246/app/api/user/paymentStripe",
          headers: {'x-api-key': myPrefs.getString(STORE_PREFS.USER_API_KEY)
          },
          body: {
            'amount': price.toString(),
            'token': tokenId,
          }

      );

      if (response.statusCode == 200 ) {
        //enter your code

        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");


        final jsonData = json.decode(response.body);


        if (jsonData["success"] == true) {
          Fluttertoast.showToast(
              msg: "Payment Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1
          );
          _navigateToNextScreen(context);
          print("=========success message===="+jsonData["data"]["seller_message"].toString());

        }

        else {
          Fluttertoast.showToast(
              msg: "Payment Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1
          );
        }
      }
    } on Exception catch (err) {
      print("======Error : $err");
    }


  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserAllProviderScreen()),
    );
  }

}