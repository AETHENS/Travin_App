import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:transparent_image/transparent_image.dart';

class SlideShow extends StatefulWidget {
  String foto1, foto2, foto3;
  SlideShow(
      {Key? key, required this.foto1, required this.foto2, required this.foto3})
      : super(key: key);

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height / 1.7,
            width: MediaQuery.of(context).size.width,
            child: ImageSlideshow(
              children: [
                FadeInImage.assetNetwork(
                  placeholder: 'assets/images/load2.png',
                  image:
                      'https://travin.darfrure.my.id/storage/img_travel${widget.foto1}',
                  fit: BoxFit.fill,
                ),
                FadeInImage.assetNetwork(
                  placeholder: 'assets/images/load2.png',
                  image:
                      'https://travin.darfrure.my.id/storage/img_travel${widget.foto2}',
                  fit: BoxFit.fill,
                ),
                FadeInImage.assetNetwork(
                  placeholder: 'assets/images/load2.png',
                  image:
                      'https://travin.darfrure.my.id/storage/img_travel${widget.foto3}',
                  fit: BoxFit.fill,
                ),
              ],
              isLoop: true,
              autoPlayInterval: 5000,
              indicatorColor: Colors.amber,
            )));
  }
}
