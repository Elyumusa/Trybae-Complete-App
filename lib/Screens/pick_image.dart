import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image_cropper/image_cropper.dart';

class PickImage extends StatefulWidget {
  @override
  _PickImageState createState() => _PickImageState();
}

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

class _PickImageState extends State<PickImage> {
  final ImagePicker _picker = ImagePicker();
  String imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (Bcontext) {
          return Center(
            child: Column(
              children: [
                imagePath == null ? Text('') : CircleAvatar(backgroundImage: FileImage(File(imagePath)),),
                if (pickedFile != null)
                  ElevatedButton(
                      child: const Text('crop photo'),
                      onPressed: () {
                        cropImage(pickedFile.path);
                      }),
                ElevatedButton(
                    child: const Text('upload photo'),
                    onPressed: () {
                      if (pickedFile != null) {
                        uploadPhoto(pickedFile);
                      }
                    }),
                ElevatedButton(
                    child: const Text('select photo'),
                    onPressed: () {
                      pickimage(context, ImageSource.camera);
                    }),
                if (task != null)
                  StreamBuilder<TaskSnapshot>(
                      stream: task.snapshotEvents,
                      builder: (context, AsyncSnapshot<TaskSnapshot> snapshot) {
                        num percentage;
                        snapshot.data != null
                            ? percentage = snapshot.data.bytesTransferred /
                                snapshot.data.totalBytes
                            : percentage;
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              LinearProgressIndicator(
                                value: percentage == null ? 0 : percentage,
                              ),
                              Text('${(percentage == null ? 0:percentage * 100).toStringAsFixed(0)}')
                            ],
                          ),
                        );
                      }),
              ],
            ),
          );
        }),
      ),
    );
  }

  firebase_storage.UploadTask task;
  PickedFile pickedFile;
  pickimage(BuildContext context, ImageSource source) async {
    try {
      print("i'm here");
      pickedFile = await _picker.getImage(source: source);
      setState(() {
        imagePath = pickedFile.path;
      });
      print('${pickedFile.path}');
    } catch (e) {
      print(e);
    }
  }

  void uploadPhoto(PickedFile pickedFile) async {
    firebase_storage.Reference ref =
        storage.ref().child('images').child('firstProfilepic.jpg');
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': pickedFile.path});
    try {
      print(io.File(pickedFile.path));
      final t = ref.putFile(io.File(pickedFile.path));
      setState(() {
        task = t;
      });
      print(
          '${await ref.putFile(io.File(pickedFile.path))}'); //.putFile(io.File(pickedFile.path), metadata);
    } catch (e) {
      print(e);
    }
  }

  void cropImage(String path) async {
    final cropped = await ImageCropper.cropImage(sourcePath: path);
    setState(() {
      cropped != null ? imagePath = cropped.path : imagePath;
    });
  }
}
