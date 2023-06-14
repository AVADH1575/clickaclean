import 'package:click_a_clean/ApiHit/TestGrid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

  class GridExample extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
  }

  class _MyHomePageState extends State< GridExample> {
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
        home: Scaffold(
        body:  SingleChildScrollView(

        child:Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/home_option.png'),
                  fit: BoxFit.cover
              ),
            ),

        child:Column(
            //shrinkWrap: true,
            children: <Widget>[
           Padding(
             padding:EdgeInsets.only(top: 20),
             child: Text("How are you Feeling?",style: TextStyle(fontSize:24 ,color: Colors.black),textAlign: TextAlign.center,)
           ),
            Padding(
                padding:EdgeInsets.only(top: 20),
            child:Image.asset("assets/images/walk3-2x.png",height: 100,)),

      Container(

          padding: const EdgeInsets.all(0),
          child:GridView.count(
            primary: false,
            shrinkWrap: true,

padding: const EdgeInsets.all(30),
crossAxisSpacing: 0,
mainAxisSpacing: 0,
crossAxisCount: 2,
children: <Widget>[
  Container(


    child: Padding(
        padding: EdgeInsets.only(left: 10,top: 10,right: 8),

        child:RaisedButton(
          child: Center(
            child: Text("Stressed",style: TextStyle(fontSize:17 ,color: Colors.black),),
          ),
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blueGrey)),
          onPressed: (){
            //_navigateToNextScreen1(context);
          },
          color: Colors.blue,

        )),


//const Text('Heed not the rabble'),
    color: Colors.white,

  ),
Container(


child: Padding(
    padding: EdgeInsets.only(top: 10,right: 10,left: 2),

  child:RaisedButton(
    child: Center(
      child: Text("Unmotivated",style: TextStyle(fontSize:17 ,color: Colors.black),),
    ),
    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blueGrey)),
    onPressed: (){
      //_navigateToNextScreen1(context);
    },
    color: Colors.lightGreenAccent,
  
)),


//const Text('Heed not the rabble'),
color: Colors.white,
  
),
  Container(


    child: Padding(
        padding: EdgeInsets.only(left: 10,top: 10,right: 8),

        child:RaisedButton(
          child: Center(
            child: Text("Defensive",style: TextStyle(fontSize:17 ,color: Colors.black),),
          ),
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blueGrey)),
          onPressed: (){
            //_navigateToNextScreen1(context);
          },
          color: Colors.lightGreen,

        )),
//const Text('Heed not the rabble'),
    color: Colors.white,

  ),
  Container(

    child: Padding(
        padding: EdgeInsets.only(top: 10,right: 10,left: 2),

        child:RaisedButton(
           child: Center(
        child: Text("Tired",style: TextStyle(fontSize:17 ,color: Colors.black),),
  ),
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blueGrey)),
          onPressed: (){
            //_navigateToNextScreen1(context);
          },
          color: Colors.blue,

        )),


//const Text('Heed not the rabble'),
    color: Colors.white,

  ),
  Container(

    child: Padding(
        padding: EdgeInsets.only(left: 10,top: 10,right: 10),

        child:RaisedButton(
          child: Center(
            child: Text("Angry",style: TextStyle(fontSize:17 ,color: Colors.black),),
          ),
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blueGrey)),
          onPressed: (){
            //_navigateToNextScreen1(context);
          },
          color: Colors.lightGreenAccent,

        )),


//const Text('Heed not the rabble'),
    color: Colors.white,

  ),
  Container(


    child: Padding(
        padding: EdgeInsets.only(top: 10,right: 10,left: 2),

        child:RaisedButton(
          child: Center(
            child: Text("Depressed",style: TextStyle(fontSize:17 ,color: Colors.black),),
          ),
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blueGrey)),
          onPressed: (){
           // _navigateToNextScreen1(context);
          },
          color: Colors.lightGreen,

        )),


//const Text('Heed not the rabble'),
    color: Colors.white,

  ),
  Container(


    child: Padding(
        padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 10),

        child:RaisedButton(
          child: Center(
            child: Text("Defective",style: TextStyle(fontSize:17 ,color: Colors.black),),
          ),
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blueGrey)),
          onPressed: (){
            //_navigateToNextScreen1(context);
          },
          color: Colors.blue,

        )),


//const Text('Heed not the rabble'),
    color: Colors.white,

  ),
  Container(


    child: Padding(
        padding: EdgeInsets.only(top: 10,right: 10,left: 2,bottom: 10),

        child:RaisedButton(
          child: Center(
            child: Text("Worried",style: TextStyle(fontSize:17 ,color: Colors.black),),
          ),
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blueGrey)),
          onPressed: (){
            //_navigateToNextScreen1(context);
          },
          color: Colors.lightGreenAccent,

        )),


//const Text('Heed not the rabble'),
    color: Colors.white,

  ),
],
))])))));}

//  void _navigateToNextScreen1(BuildContext context) {
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => GridDashboard()),
//    );
//  }
}