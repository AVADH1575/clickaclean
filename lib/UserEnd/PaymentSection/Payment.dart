import 'package:click_a_clean/UserEnd/PaymentSection/paymentSucess.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/CardsDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:io';

//import 'add_new_address.dart';

class Payment extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
// TODO: implement createState
    return _Payment();
  }
}

class _Payment extends State<Payment> {


  int correctScore = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret = "sk_test_51HhXi8AG6mY0Ps4qC4GaMWatXCqPQwt6iuTYOYlW20unxSaOpFaf98fdwby1vpfshQoqnpqDjioYQ736EoU2oYaF00apno4WFm"; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;

  ScrollController _controller = ScrollController();


  @override
  void initState() {
// TODO: implement initState
    super.initState();


    StripePayment.setOptions(
        StripeOptions(publishableKey: "pk_test_51HhXi8AG6mY0Ps4qQLdM1XLxqLAzyQqPan1eeo5gywLFP5bCemxv372S2jKTH314iuSRJ0obKIl5nZxCXId7BT4d00tlLUN2xk",
            merchantId: "Test",
            androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 121, 204, 1),
        title: Text('Select Payment Method'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                  child:Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        'Credit/Debit Cards?',
                        style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 22),
                        textAlign: TextAlign.start
                    ),
                  ),),




                new Container(
                  child: Column(
                    children: [
                      Divider(
                          color: Colors.black
                      ),
                      Container(
                        padding: EdgeInsets.only(left:20.0),
                        child:FlatButton(
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text(
                                  'Add a new Card',
                                  style: TextStyle(color: new Color(0xFF7D79CC),fontSize: 15),
                                  textAlign: TextAlign.start
                              ),
                              new Container(
                              ),
                            ],
                          ),onPressed: (){


                          if (Platform.isIOS) {
                           // _controller.jumpTo(450);
                            _navigateToCardDetail(context);
//                            StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest()).then((paymentMethod) {
//                              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('${paymentMethod.id}')));
//                              setState(() {
//
//                                _paymentMethod = paymentMethod;
//                              });
//                            }).catchError(setError);
                          }
                          _navigateToCardDetail(context);
//                          StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest()).then((paymentMethod) {
//                            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('${paymentMethod.id}')));
//                              setState(() {
//
//                              _paymentMethod = paymentMethod;
//
//                              print("-======card____"+paymentMethod.card.cvc+paymentMethod.card.token+paymentMethod.card.number+paymentMethod.card.expMonth.toString()+paymentMethod.card.expYear.toString());
//
//                              });
//                          }).catchError(setError);
                        },
                        ),
                      ),
                      Divider(
                          color: Colors.black
                      ),
                    ],
                  ),

                ),
              ],),



          ],

        ),),
// bottomNavigationBar: new Container(
//
// color: Color.fromRGBO(125, 121, 204, 1),
// height: 52,
//
// child:Container(
//
// color: Color.fromRGBO(125, 121, 204, 1),
// height: 52,
//
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
//
//
// Align(
// alignment: FractionalOffset.bottomLeft,
// child: FlatButton(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Align(
// alignment: FractionalOffset.centerLeft,
// child:FlatButton(
// onPressed: () {},
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
//
// Text("",style: TextStyle(color: Colors.white,fontSize: 18)),
// ],)
// ),),
// ],),
//
//
// ],
// ),
// ),),
//
//
//
// Align(
// alignment: FractionalOffset.bottomRight,
// child: FlatButton(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: <Widget>[
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: <Widget>[
// Align(
// alignment: FractionalOffset.center,
// child:FlatButton(
// onPressed: () {
// _navigateToNextScreen(context);
// },
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: <Widget>[
// Text("Continue",style: TextStyle(color: Colors.white,fontSize: 18)),
//
// Icon(
// Icons.arrow_forward_ios,color: Colors.white)
//
// ],
//
// )
//
// ),),
//
// ],),
//
//
// ],
// ),
// ),),
//
// ],),
// ),
// ),


    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentSucess()),
    );
  }
  void _navigateToCardDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardsDetails()),
    );
  }

}