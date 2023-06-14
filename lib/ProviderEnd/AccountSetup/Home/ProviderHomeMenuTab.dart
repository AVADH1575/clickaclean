
import 'package:click_a_clean/ProviderEnd/AccountSetup/NewLead/NewLeadScreen.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/Profile/provider_profile_screen.dart';
import 'package:click_a_clean/ProviderEnd/AccountSetup/ProviderHistory/Provider_booking_history.dart';
import 'package:click_a_clean/UserEnd/menu_fragment/home_menu_fragment.dart';
import 'package:flutter/material.dart';

import 'Provider_home_menu_fragment.dart';

class ProviderHomeScreenTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProviderHomeScreenTab();
  }
}
class _ProviderHomeScreenTab extends State<ProviderHomeScreenTab> {
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
                          new Icon(Icons.call_received,size: 22.5),
                          Text("New Leads"),],)

                  ),
                  Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(Icons.history,size: 22.5),
                          Text("History"),],)

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
                labelStyle: TextStyle(fontSize: 11.0),
                //indicatorSize: TabBarIndicatorSize.label,
                //indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
              ),),

          ),
          backgroundColor: Color.fromRGBO(241, 123, 72, 1),
        ),
      ),
    );

  }

}
class FirstMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: ProviderHomeMenu(),

    );
  }
}
class SecondMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: NewLeadScreen(),
    );
  }
}
class ThirdMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: ProviderBookingHistoryTabBar(),

    );
  }
}
class FourthMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: ProvideProfileScreen(),

    );
  }
}