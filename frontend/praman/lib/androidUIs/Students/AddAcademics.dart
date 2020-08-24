import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:praman/Services/addRecords.dart';
import 'package:praman/Widgets/AddRecordHeadingTextStyle.dart';
import 'package:praman/Widgets/Appbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddAcademics extends StatefulWidget {
  @override
  _AddAcademicsState createState() => _AddAcademicsState();
}

class _AddAcademicsState extends State<AddAcademics> {
  String _gpa = null;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  TextEditingController _orgIDController = TextEditingController();

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

  TextField orgIDInput() {
    return TextField(
      controller: _orgIDController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          labelText: "Enter the organization ID",
          labelStyle: TextStyle(color: Colors.white70)),
      maxLength: 12,
      style: TextStyle(fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    AddRecords addRecordProvider = Provider.of<AddRecordsBase>(context);

    return Scaffold(
      appBar: getAppbar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Add a new Record",
                  style: addRecordHeading,
                ),
              ),
              SizedBox(height: 20),
              titleInput(),
              SizedBox(
                height: 5,
              ),
              detailsInput(),
              SizedBox(
                height: 5,
              ),
              orgIDInput(),
              SizedBox(
                height: 5,
              ),
              DropdownButton(
                items: <DropdownMenuItem>[
                  DropdownMenuItem(
                    child: Text(1.toString()),
                    value: 1.toString(),
                  ),
                  DropdownMenuItem(
                    child: Text(2.toString()),
                    value: 2.toString(),
                  ),
                  DropdownMenuItem(
                    child: Text(3.toString()),
                    value: 3.toString(),
                  ),
                  DropdownMenuItem(
                    child: Text(4.toString()),
                    value: 4.toString(),
                  ),
                  DropdownMenuItem(
                    child: Text(5.toString()),
                    value: 5,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _gpa = value;
                  });
                },
                value: _gpa,
                hint: Text("GPA"),
              ),
              SizedBox(
                height: 5,
              ),
              _image != null ? Image.file(_image) : Container(),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  FloatingActionButton.extended(
                    heroTag: "uploadImage",
                    backgroundColor: Colors.white.withOpacity(.9),
                    onPressed: () async {
                      await chooseViaGallery();
                      await processImage();
                    },
                    label: Text("Upload File"),
                    icon: Icon(Icons.image),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton.extended(
                    heroTag: "ClickImage",
                    backgroundColor: Colors.white.withOpacity(.9),
                    onPressed: () async {
                      await chooseViaCamera();
                      await processImage();
                    },
                    label: Text("Click Image"),
                    icon: Icon(Icons.camera),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton.icon(
                padding: EdgeInsets.all(10),
                color: Colors.white30,
                onPressed: () async {
                  await addRecordProvider.addAcademicRecords(
                    title: _titleController.text,
                    details: _detailsController.text,
                    gpa: _gpa,
                    organizationID: _orgIDController.text,
                    image: _image != null
                        ? base64Encode(_image.readAsBytesSync())
                        : "",
                  );
                },
                icon: Icon(Icons.send),
                label: Text("ADD"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
