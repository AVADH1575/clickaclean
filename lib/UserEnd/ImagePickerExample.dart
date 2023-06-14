import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';



class ImagePickerExample extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ImagePickerExample> {
  int _selectedIndex = 0;


  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("StackoverFlow"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _dialogCall(context);
        },
      ),
    );
  }

  Future<void> _dialogCall(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog();
        });
  }
}


class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  String imagePath;
  Image image;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Container(child: image!= null? image:null),
            GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.camera),
                    SizedBox(width: 5),
                    Text('Take a picture                       '),
                  ],
                ),
                onTap: () async{
    var image = await ImagePicker.pickImage(
    source: ImageSource.camera).whenComplete((){
    setState(() {
    });
    }
    );
    setState(() {
      image = image;
    });


                }
                ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
    );
  }


  Future getImageFromCamera() async {
    var x = await ImagePicker.pickImage(source: ImageSource.camera);
    imagePath = x.path;
    image = Image(image: FileImage(x));
  }
  // This funcion will helps you to pick a Video File from Camera
//  _pickVideoFromCamera() async {
//    File video = await ImagePicker.pickVideo(source: ImageSource.camera);
//    _cameraVideo = video;
//    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)..initialize().then((_) {
//      setState(() { });
//      _cameraVideoPlayerController.play();
//    });
//  }


}
