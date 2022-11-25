import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class SliderIntro extends StatefulWidget {
  SliderIntro({Key? key}) : super(key: key);

  @override
  State<SliderIntro> createState() => _SliderIntroState();
}

class _SliderIntroState extends State<SliderIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ImageSlideshow(
            children: [
              Image(
                  image: AssetImage('assets/images/introapp/1.png'),
                  fit: BoxFit.fill),
              Image(
                  image: AssetImage('assets/images/introapp/2.png'),
                  fit: BoxFit.fill),
              Image(
                  image: AssetImage('assets/images/introapp/5.png'),
                  fit: BoxFit.fill),
            ],
            isLoop: true,
            autoPlayInterval: 5000,
            indicatorColor: Colors.amber,
          )),
    );
  }
}
