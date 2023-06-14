
import 'package:click_a_clean/UserEnd/login/login_screen.dart';
import 'package:flutter/material.dart';

class ChooseCountry extends StatefulWidget {
  createState() => ChooseCountryState();
}

class ChooseCountryState extends State<ChooseCountry> {
  List<Widget> widgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgets = new List();
  }

  Widget CardWidget(int index) {
    return Card(
      child: Text("$index hello"),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.deepPurple,
//          title: Text("Finance"),
//          centerTitle: true,
//          elevation: 0.0,
//          leading: Padding(
//            padding: EdgeInsets.only(left: 5.0),
//            child: Icon(Icons.menu),
//          ),
//        ),
        body: ListView(

          children: <Widget>[

            TopView(),
          ],
        ));
  }

  Widget TopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              height: 124.0,
              width: double.infinity,
              decoration: BoxDecoration(color: Color.fromRGBO(125, 121, 204, 1)),
            ),

            Positioned(
              top: 18.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                Image.asset(
                'assets/images/logo-white.png',
                  fit: BoxFit.contain,
                  height: 50,),
                    Text(
                      "Welcome to Click A Clean \nChoose a Country to get started",
                      style: TextStyle(fontSize: 17.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Column(children: ListCol())
          ],
        ),
      ],
    );
  }

  List<Widget> ListCol() {
    List<Widget> d = [];
    d.add(SizedBox(
      height: 125.0,
    ));

    for (var i = 0; i < 9; i++) {
      d.add(CustomCard());
    }
    return d;
  }

  Widget CustomCard(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
      width: double.infinity,
      child: Material(
          borderRadius: BorderRadius.circular(0.0),
          elevation: 0.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
            child: Column(
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  child: InkResponse(
                                    onTap: (){},
                                    child: Image.asset(
                                      'assets/images/india_flag.png',
                                      fit: BoxFit.contain,
                                      height: 45,

                                    ),
                                  )
                              ),
                              SizedBox(height: 25.0,),
                              Text("\   India",style: TextStyle(fontSize: 20.0),),
//      RaisedButton(
//        textColor: Colors.black,
//        color: Colors.white,
//        child: Text('     India'),
//        onPressed: () {
//          _navigateToNextScreen(context);
//        },
//
//                              //Icon(Icons.check, size: 24.0, color: Colors.grey),
//
//      ),
                               ],
                              ),

                          ),
                        )
        ],
                    ),

                  ],
                )

            ),
          )
      );

  }

  Widget AppWidget() {
    return Container(
        padding: EdgeInsets.only(left: 15.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Icon(Icons.menu, size: 24.0, color: Colors.white),
            ),
            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Text("Finance",
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ),
            Container(
              child: null,
            )
          ],
        ));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}