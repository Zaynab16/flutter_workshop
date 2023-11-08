import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imageList = [
  'assets/image/num1.png',
  'assets/image/num1.png',
  'assets/image/num1.png',
];

final List<String> imageTextList = [
  'Num1',
  'Num2',
  'Num3',
];

class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int _currentIndex = 0;
  CarouselController _carouselController = CarouselController();

  void _onIndicatorTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _carouselController.animateToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFDFE),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              enableInfiniteScroll: false, // Disable infinite scroll
              onPageChanged: (index, _) {
                setState(() {
                  _currentIndex = index;
                });
              },
              onScrolled: (double? _) {
                if (_currentIndex == imageList.length - 1) {
                  _carouselController.stopAutoPlay(); // Stop autoplay at the last picture
                  Future.delayed(Duration(milliseconds: 5000), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CarouselScreen()),
                    );
                  });
                }
              },
            ),
            items: imageList.asMap().entries.map((entry) {
              int index = entry.key;
              String imagePath = entry.value;
              String imageText = imageTextList[index];
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          imageText,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.map((path) {
              int index = imageList.indexOf(path);
              return GestureDetector(
                onTap: () => _onIndicatorTapped(index),
                child: Container(
                  width: 10,
                  height: 4,
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12.0),
                    color: _currentIndex == index ? Color(0xFF38C419) : Colors.blue,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
