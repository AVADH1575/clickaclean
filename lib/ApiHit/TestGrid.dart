import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TestGrid extends StatelessWidget {
  final dataKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: true,
      appBar: new AppBar(
        title: const Text('Home'),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(height: 160.0, width: double.infinity, child: new Card()),
            new SizedBox(height: 160.0, width: double.infinity, child: new Card()),
            new SizedBox(height: 160.0, width: double.infinity, child: new Card()),
            // destination
            new Card(
              key: dataKey,
              child: new Text("data\n\n\n\n\n\ndata"),
            )
          ],
        ),
      ),
      bottomNavigationBar: new FlatButton(
        onPressed: () => Scrollable.ensureVisible(dataKey.currentContext),
        child: new Text("Scroll to data"),
      ),
    );
  }
}