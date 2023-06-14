
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'menu_fragment/booking_history/booking_history.dart';
import 'menu_fragment/help_menu_fragment.dart';
import 'menu_fragment/home_menu_fragment.dart';
import 'menu_fragment/profile_menu_fragment.dart';
import 'menu_fragment/profile_screen.dart';


class HomeScreen_Fragment extends StatefulWidget {
  final FirebaseUser user;


  HomeScreen_Fragment({this.user});

  @override
  State<StatefulWidget> createState() {
    return _HomeStateScreen();
  }
}
class _HomeStateScreen extends State<HomeScreen_Fragment> {


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new MaterialApp(
      color: Colors.yellow,
      home: DefaultTabController(


        length: 4,
        child: new Scaffold(
//          appBar: AppBar(
//            title: Text("Car Clean"),
//            backgroundColor: Color.fromRGBO(125, 121, 204, 1),
//            centerTitle: true,
//
//          ),

          body: TabBarView(


            children: [
              new FirstMenuWidget(),
              new SecondMenuWidget(),
              new ThirdMenuWidget(),
              new FourthMenuWidget(),
            ],
          ),
          bottomNavigationBar: SizedBox(height: 50,
          child: Align(
          alignment: Alignment.center,
          child:new TabBar(

            tabs: [

              Tab(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   new Icon(Icons.home,size: 22.5),
                  Text("Home"),],)

              ),
              Tab(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                  new Icon(Icons.history,size: 22.5),
                  Text("Bookings"),],)

              ),
              Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.help,size: 22.5),
                      Text("Help"),],)

              ),
              Tab(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.supervised_user_circle,size: 22.5),
                      Text("Profile"),],),)



            ],
            labelColor: Colors.white,
            unselectedLabelColor: Color.fromRGBO(255, 255, 255, 60),
            labelStyle: TextStyle(fontSize: 12.0),
            //indicatorSize: TabBarIndicatorSize.label,
            //indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.transparent,
          ),),

          ),
          backgroundColor: Color.fromRGBO(125, 121, 204, 1),
        ),
      ),
    );

  }

}
class FirstMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: HomeMenu(),

    );
  }
}
class SecondMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: BookingHistoryTabBar(),
    );
  }
}
class ThirdMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: Help_Menu(),

    );
  }
}
class FourthMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: ProfileMenu(),

    );
  }
}