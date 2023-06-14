import 'package:flutter/material.dart';

import 'UserActiveBookingScreen.dart';
import 'UserPastBookingScreen.dart';

class BookingHistoryTabBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          title: new Center(child: new Text("My Bookings", textAlign: TextAlign.center)),
          backgroundColor: Color.fromRGBO(125, 121, 204, 1),
          bottom: TabBar(
            tabs: [
              Tab( text: "Active Bookings",),
              Tab( text: "Past Bookings"),
            ],
          ),

        ),
        body: TabBarView(
          children: [
            new ActiveBookingScreen(),
            new PastBookingScreen(),
          ],
        ),
      ),
    );
  }
}
class ActiveBookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: UserActiveBookingScreen(),

    );
  }
}
class PastBookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: UserPastBookingScreen(),

    );
  }
}