import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:praman/Services/addRecords.dart';
import 'package:praman/Services/contractData.dart';
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
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  TextEditingController _orgIDController = TextEditingController();
  TextEditingController _gpaController = TextEditingController();

  File _image;
  final picker = ImagePicker();
  String certifierDetails;

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
          labelText: "Enter the certifier ID",
          labelStyle: TextStyle(color: Colors.white70)),
      maxLength: 12,
      style: TextStyle(fontSize: 20),
      onEditingComplete: () async {
        if (_orgIDController.text.length == 12) {
          String response =
              await ContractData.getCertifier(_orgIDController.text);
          Map data = jsonDecode(response);

          setState(() {
            certifierDetails = data["data"][0]["name"] +
                " - " +
                data["data"][0]["typeOfOrganization"];
          });
        }
      },
    );
  }

  TextField gpaInput() {
    return TextField(
      controller: _gpaController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          labelText: "GPA",
          labelStyle: TextStyle(color: Colors.white70)),
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
              certifierDetails == null ? Text("") : Text(certifierDetails),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(child: gpaInput()),
                  SizedBox(
                    width: 20,
                  ),
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
              SizedBox(
                height: 5,
              ),
              _image != null ? Image.file(_image) : Container(),
              SizedBox(
                height: 30,
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
                    gpa: _gpaController.text,
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
