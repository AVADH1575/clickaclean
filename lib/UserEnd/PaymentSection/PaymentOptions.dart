import 'package:click_a_clean/UserEnd/PaymentSection/paymentSucess.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/CardsDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'add_new_address.dart';

class PaymentOptions extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
// TODO: implement createState
    return _PaymentOptions();
  }
}

class _PaymentOptions extends State<PaymentOptions> {

  int _radioValue1 = -1;
  int correctScore = 0;
  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;
  int _radioValue5 = -1;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
// Fluttertoast.showToast(msg: 'Correct !',toastLength: Toast.LENGTH_SHORT);
          correctScore++;
          break;
        case 1:
// Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
// Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 121, 204, 1),
        title: Text('Payment Options'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
     child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[





              new Container(
                child: Column(
                  children: [

                    Container(
                      padding: EdgeInsets.only(left:20.0,top:20.0,bottom:20.0),
                      child: Row(
                        children: [

                          Text(
                              'Pay Using',
                              style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 17),
                              textAlign: TextAlign.start
                          ),
                          new Container(
                          ),
                        ],
                      ),
                    ),
                    Divider(
                        color: Colors.black
                    ),
                  ],
                ),

              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                child:Align(
                  alignment: Alignment.topLeft,
                  child:FlatButton(
                  child: Text(
                      'Credit/Debit Cards?',
                      style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 20),
                      textAlign: TextAlign.start
                  ),onPressed: (){
                    _navigateToCreditScreen(context);
                  },),
                ),),
              Divider(
                  color: Colors.black
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                child:Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      'NetBanking',
                      style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 20),
                      textAlign: TextAlign.start
                  ),
                ),),
              Divider(
                  color: Colors.black
              ),
            ],),



        ],

      ),),
//      bottomNavigationBar: new Container(
//
//        color: Color.fromRGBO(125, 121, 204, 1),
//        height: 52,
//
//        child: Container(
//
//          color: Color.fromRGBO(125, 121, 204, 1),
//          height: 52,
//
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//
//
//              Align(
//                alignment: FractionalOffset.bottomLeft,
//                child: FlatButton(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Align(
//                            alignment: FractionalOffset.centerLeft,
//                            child:FlatButton(
//                                onPressed: () {},
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.start,
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//
//                                    Text("",style: TextStyle(color: Colors.white,fontSize: 18)),
//                                  ],)
//                            ),),
//                        ],),
//
//
//                    ],
//                  ),
//                ),),
//
//
//
//              Align(
//                alignment: FractionalOffset.bottomRight,
//                child: FlatButton(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Align(
//                            alignment: FractionalOffset.center,
//                            child:FlatButton(
//                                onPressed: () {
//                                  _navigateToNextScreen(context);
//                                },
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text("Continue",style: TextStyle(color: Colors.white,fontSize: 18)),
//
//                                    Icon(
//                                        Icons.arrow_forward_ios,color: Colors.white)
//
//                                  ],
//
//                                )
//
//                            ),),
//
//                        ],),
//
//
//                    ],
//                  ),
//                ),),
//
//            ],),
//        ),
//      ),


    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentSucess()),
    );
  }
  void _navigateToCreditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardsDetails()),
    );
  }
}