import 'dart:io';
import 'package:path/path.dart' as path1;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petdot/presentation/AddProdectPage/add_prodct.dart';

List<String> downloadURLs = [];

class ImagesList extends StatefulWidget {
  const ImagesList({Key? key}) : super(key: key);

  @override
  State<ImagesList> createState() => _ImagesListState();
}

class _ImagesListState extends State<ImagesList> {
  String? imagePath;
  List<String> imagelist = [];

  Future<void> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  Future<void> uploadImagesToFirebase(
      List<String> imagePaths, BuildContext context) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    final firebase_storage.Reference storageRef = storage.ref();

    for (String imagePath in imagePaths) {
      final file = File(imagePath);
      final fileName = path1.basename(file.path);
      final firebase_storage.Reference imageRef = storageRef.child(fileName);

      try {
        await imageRef.putFile(file);
        final downloadURL = await imageRef.getDownloadURL();
        downloadURLs.add(downloadURL);
      } catch (error) {
        final snackBar =
            SnackBar(content: Text('Failed to upload image: $error'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    // You can use downloadURLs as needed, for example, you can update the Firestore document with the download URLs.
    // For demonstration purposes, let's just print the download URLs.
    downloadURLs.forEach((url) => print('Download URL: $url'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            IconButton(
              onPressed: () {
                takePhoto().then((value) {
                  if (imagelist.length < 4) {
                    return imagelist.add(imagePath!);
                  }
                });
              },
              icon: Icon(Icons.add),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: imagelist.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: Image(
                          image: FileImage(File(imagelist[index])),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                uploadImagesToFirebase(imagelist, context);
                Navigator.of(context).pop();
              },
              child: Text('Done'),
            )
          ],
        ),
      ),
    );
  }
}
