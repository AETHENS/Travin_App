import 'package:flutter/material.dart';
import 'package:travin_app/bottomtab.dart';
import 'package:travin_app/common/color.dart';

class SuccesNotification extends StatefulWidget {
  String image, heading, subheading;
  SuccesNotification(
      {Key? key,
      required this.image,
      required this.heading,
      required this.subheading})
      : super(key: key);

  @override
  State<SuccesNotification> createState() => _SuccesNotificationState();
}

class _SuccesNotificationState extends State<SuccesNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24, bottom: 8),
            height: 94,
            width: 94,
            child: Image(image: AssetImage(widget.image)),
          ),
          Text(
            widget.heading,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Text(
            widget.subheading,
            style: TextStyle(fontSize: 10, color: colorValue.greytextColor),
          ),
          SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavBar(),
                  ));
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    color: colorValue.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "Kembali ke beranda",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
