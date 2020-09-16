import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:praman/Widgets/AddRecordHeadingTextStyle.dart';
import 'package:praman/Widgets/Appbar.dart';

class AddResearchPaper extends StatefulWidget {
  @override
  _AddResearchPaperState createState() => _AddResearchPaperState();
}

class _AddResearchPaperState extends State<AddResearchPaper> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  TextEditingController _fieldController = TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future<void> chooseViaGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
  }

  Future<void> chooseViaCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    _image = File(pickedFile.path);
  }

  Future processImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.ratio5x3
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path,
      _image.path,
      quality: 10,
      rotate: 0,
    );
    setState(() {
      _image = result;
    });
  }

  TextField titleInput() {
    return TextField(
      controller: _titleController,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          labelText: "Title",
          labelStyle: TextStyle(color: Colors.white70)),
      maxLength: 30,
      maxLines: 5,
      minLines: 1,
      style: TextStyle(fontSize: 20),
    );
  }

  TextField detailsInput() {
    return TextField(
      controller: _detailsController,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          labelText: "Details",
          labelStyle: TextStyle(color: Colors.white70)),
      maxLength: 1000,
      minLines: 3,
      maxLines: 40,
      style: TextStyle(fontSize: 20),
    );
  }

  TextField fieldInput() {
    return TextField(
      controller: _fieldController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          labelText: "Field of Research",
          labelStyle: TextStyle(color: Colors.white70)),
      style: TextStyle(fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppbar(),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "Add a new Paper",
                    style: addRecordHeading,
                  ),
                  SizedBox(height: 30),
                  titleInput(),
                  SizedBox(height: 30),
                  detailsInput(),
                  SizedBox(height: 30),
                  fieldInput(),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          _image != null ? Text("File Attached") : Text(""),
                          FloatingActionButton.extended(
                            heroTag: "uploadImage",
                            backgroundColor: Colors.white38.withOpacity(.7),
                            onPressed: () async {
                              await chooseViaGallery();
                              await processImage();
                            },
                            label: Text("Upload File"),
                            icon: Icon(Icons.image),
                          ),
                        ],
                      ),
                      FloatingActionButton.extended(
                        heroTag: "addRecord",
                        backgroundColor: Colors.white38.withOpacity(.7),
                        onPressed: () async {
                          // await chooseViaGallery();
                          // await processImage();
                        },
                        label: Text("Add"),
                        icon: Icon(Icons.send_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
