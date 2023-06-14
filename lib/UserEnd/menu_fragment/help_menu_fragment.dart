import 'package:flutter/material.dart';
class Help_Menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

      home: _helpscreen(),
    );
  }

}

class _helpscreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _helpscreenpage();
  }
}

class _helpscreenpage extends State<_helpscreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        title: Text("Need Help?"),
        backgroundColor: Color.fromRGBO(125, 121, 204, 1),centerTitle: true,),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) =>
            EntryItem(data[index]),
        itemCount: data.length,
      ),
    );
  }

}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}
final String subtitle ='Our professionals will generally reach within the selected slot of booking. We track if the job is not started on the time and our customer experience associates start working on the issue automatically.';

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Professional has not been assigned.',
    <Entry>[
      Entry(subtitle),
    ],
  ),
  Entry(
    'When will the professional reach?',
    <Entry>[
      Entry(subtitle),
    ],
  ),
  Entry(
    'I want to reschedule my service booking.',
    <Entry>[
      Entry(subtitle),
    ],
  ),
  Entry(
    'I want to cancel my service booking.',
    <Entry>[
      Entry(subtitle),
    ],
  ),
];
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}