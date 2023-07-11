import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselClass extends StatefulWidget {
  const CarouselClass({Key? key}) : super(key: key);

  @override
  State<CarouselClass> createState() => _CarouselClassState();
}

class _CarouselClassState extends State<CarouselClass> {
  List<String> ImageList = [
    "assets/images/photo_2023-05-03_01-00-46.jpg",
    "assets/images/photo_2023-05-03_01-00-47.jpg",
    "assets/images/photo_2023-05-03_01-00-48.jpg",
    "assets/images/photo_2023-05-03_01-00-48 (2).jpg",
    "assets/images/photo_2023-05-03_01-00-49.jpg",
    "assets/images/photo_2023-05-03_01-00-50.jpg",
    "assets/images/photo_2023-05-03_01-00-50 (2).jpg",
  ];
  int InitialPage = 0;
  CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FUI-MU"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height:100)
            ,
            CarouselSlider(
                carouselController: _controller,
                items: ImageList.map((ImageList) {
                  return Builder(builder: (BuildContext context) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: AssetImage(ImageList), fit: BoxFit.cover)),
                    );
                  });
                }).toList(),
                options: CarouselOptions(
                  height: 230.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      InitialPage = index;
                    });
                  },
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ImageList.asMap().entries.map((ImageList) {
                return InkWell(
                  onTap: () {
                    _controller.jumpToPage(ImageList.key);
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.all(12),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: InitialPage == ImageList.key
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      color: InitialPage == ImageList.key
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  var route = MaterialPageRoute(
                      builder: (context) => CarouselClass());
                  Navigator.push(context, route);

                },
                    child: Text('Maps for building' ,style: TextStyle(fontSize: 20, color: Colors.white),)),

              ],
            ),

          ],
        )

    );
  }
}

