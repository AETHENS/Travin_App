import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travin_app/common/color.dart';
import 'package:travin_app/ui/model/profileModel.dart';
import 'package:travin_app/ui/model/uploadmodel.dart';
import 'package:travin_app/ui/widget/pickimage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class EditProfilePage extends StatefulWidget {
  String username, imageAPI, email;
  EditProfilePage(
      {Key? key,
      required this.username,
      required this.imageAPI,
      required this.email})
      : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UploadProfile? uploadProfile;

  uploadFile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    if (_image != null) {
      // upload image saja/keduanya
      try {
        FormData formData = new FormData.fromMap({
          "name": "${_controllerUsername.text}",
          "avatar": await MultipartFile.fromFile(_image!.path, filename: '.png')
        });

        Response response =
            await Dio().post("https://travin.darfrure.my.id/api/update",
                data: formData,
                options: Options(headers: <String, String>{
                  'Authorization': 'Bearer $token',
                }));
        print("Status Code : ${response.statusCode}");
        print(response.data);

        if (response.statusCode == 200) {
          Navigator.pop(context);
        }
        return response;
      } on DioError catch (e) {
        return e.response;
      } catch (e) {}
      //
      // upload cuman username
    } else if (_image == null) {
      var response = await http.post(
          Uri.parse("https://travin.darfrure.my.id/api/update-name"),
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: {
            "name": "${_controllerUsername.text}",
          });

      print("Status Code : ${response.statusCode}");
      print(response.body);

      if (response.statusCode == 200) {
        Navigator.pop(context);
      }
    }
  }

  TextEditingController _controllerUsername = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerUsername.text = widget.username;
  }

  Dio dio = new Dio();
  File? _image;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                      height: 120,
                      width: 120,
                      child: _image == null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://travin.darfrure.my.id/storage/${widget.imageAPI}'),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(_image!),
                            )),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () async {
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
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorValue.primaryColor),
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 24,
                    color: colorValue.greytextColor,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                        child: TextFormField(
                      controller: _controllerUsername,
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                    )),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Icon(
                    Icons.email_rounded,
                    color: colorValue.greytextColor,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 12,
                            color: colorValue.greytextColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.email,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  uploadFile();
                },
                child: Container(
                  height: 50,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colorValue.primaryColor),
                  child: Center(
                    child: Text(
                      'Simpan Perubahan',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
