import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:travin_app/ui/page/pesan/succesnotification.dart';
import 'package:travin_app/ui/page/tiket/widget/tiketwidget.dart';
import 'package:travin_app/ui/widget/pickimage.dart';

class coba extends StatefulWidget {
  coba({Key? key}) : super(key: key);

  @override
  State<coba> createState() => _cobaState();
}

class _cobaState extends State<coba> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
                height: 300,
                width: 300,
                color: Colors.amber,
                child: _image == null
                    ? Center(child: Text("gaada foto"))
                    : Container(
                        height: 300,
                        width: 300,
                        child: CircleAvatar(
                          backgroundImage: FileImage(_image!),
                        ))),
            ElevatedButton(
                onPressed: () async {
                  await PickImage.selectImageFromGaleri()
                      .then((selectedFile) async {
                    if (selectedFile == null) return;

                    await PickImage.cropSelectedImage(selectedFile.path)
                        .then((croppedFile) {
                      if (croppedFile == null) return;
                      File? img = File(croppedFile.path);
                      setState(() {
                        _image = img;
                      });
                    });
                  });
                },
                child: Text("data")),
          ],
        ),
      ),
    );
  }
}
