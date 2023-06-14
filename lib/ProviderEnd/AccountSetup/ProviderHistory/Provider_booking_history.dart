import 'package:flutter/material.dart';

import 'OngoingLeadsScreen.dart';
import 'PastLeadsScreen.dart';

class ProviderBookingHistoryTabBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          title: new Center(child: new Text("Leads History", textAlign: TextAlign.center)),
          backgroundColor: Color.fromRGBO(241, 123, 72, 1),
          bottom: TabBar(
            tabs: [
              Tab( text: "Ongoing Leads",),
              Tab( text: "Past Leads"),
            ],
          ),

        ),
        body: TabBarView(
          children: [

            new OngoingBookingScreen(),
          new PastBookingScreen()
          ],
        ),
      ),
    );
  }
}
class OngoingBookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: OngoingLeadsScreen(),

    );
  }
}
class PastBookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: PastLeadsScreen(),

    );
  }
}