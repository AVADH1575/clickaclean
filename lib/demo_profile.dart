
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DEMOPROFILE extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginWidgetState();
  }
}
class _LoginWidgetState extends State<DEMOPROFILE> {



  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

    body: Padding(
    padding: EdgeInsets.all(10),
    child: ListView(
    children: <Widget>[
      IconButton(
        alignment: Alignment.topLeft,
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () {
            //_navigateToNextScreenBack(context);
          }
      ),
    Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
    child: Image(
      height: 142,
     width: 142,
     image: AssetImage('assets/images/check.png')
    )
    ),

      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child:Text("Driver:",textAlign:TextAlign.center,style: TextStyle(color: Colors.grey, fontSize: 14)
            ,)),
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child:Text("Manish Kumar",textAlign:TextAlign.center,style: TextStyle(color: Colors.black, fontWeight:FontWeight.bold,fontSize: 18)
            ,)),
      Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child:Text("Silver Grade",textAlign:TextAlign.center,style: TextStyle(color: Colors.blue, fontWeight:FontWeight.bold,fontSize: 15)
            ,)),

      Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child:Divider(height: 1,color: Colors.grey,
            )),

   Container(
        child:
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child:Text("Total trips:",style: TextStyle(color: Colors.grey, fontSize: 16)
                          ,)),
                    Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child:Text("Balance:",style: TextStyle(color: Colors.grey, fontSize: 16)
                          ,)),
                    Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child:Text("Ratings:",style: TextStyle(color: Colors.grey, fontSize: 16)
                          ,))
                  ]),


            ],
          ),),

      ),

      Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child:Divider(height: 1,color: Colors.grey,
          )),
      Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[


            Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child:Text("Phone",style: TextStyle(color: Colors.black, fontSize: 16)
                  ,)),
                  Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child:Text("+918968299802",style: TextStyle(color: Colors.black, fontSize: 16)
                        ,))

          ],
        ),),
      Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child:Text("Email",style: TextStyle(color: Colors.black, fontSize: 16)
                  ,)),
            Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child:Text("info@nemanli.com",style: TextStyle(color: Colors.black, fontSize: 16)
                  ,))
          ],
        ),),
      Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child:Text("Language",style: TextStyle(color: Colors.black, fontSize: 16)
                  ,)),
            Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child:Text("English",style: TextStyle(color: Colors.black, fontSize: 16)
                  ,))

          ],
        ),),
      Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child:Divider(height: 1,color: Colors.grey,
          )),

    Container(
    height: 60,
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    margin:  EdgeInsets.fromLTRB(0, 100, 10, 0),

    child: RaisedButton(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10)),
    textColor: Colors.white,
    color: Color.fromRGBO(0, 178, 216, 1),
    child: Text('Logout',style: TextStyle(
    fontSize: 16,
    color: Colors.white,)),
    onPressed: () {

    },
    )),
    ],
    )),
    );
  }
}