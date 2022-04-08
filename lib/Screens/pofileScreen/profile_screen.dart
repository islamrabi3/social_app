import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? pickedImage;
  ImagePicker picker = ImagePicker();
  void getImage(ImageSource src) async {
    var imagePic = await picker.pickImage(source: src);

    if (imagePic != null) {
      setState(() {
        pickedImage = File(imagePic.path);
      });
    } else {
      print('No Image Picked');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  backgroundImage:
                      pickedImage != null ? FileImage(pickedImage!) : null,
                  radius: 50.0,
                ),
                Positioned(
                  child: CircleAvatar(
                    radius: 15.0,
                  ),
                  right: 15.0,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Text('Upload From Gallary'),
                ),
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: Text('Upload From Camera'),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    pickedImage = null;
                  });
                },
                child: Text('Remove Image'))
          ]),
        ),
      ),
    );
  }
}
