import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_project/components/page/mousePage.dart';
import 'package:flutter_project/components/page/keyboardPage.dart';
import 'package:flutter_project/components/page/headphonePage.dart';
import 'package:flutter_project/components/page/homePage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _currentBody = homePage();

  void _setBody(Widget newBody) {
    setState(() {
      _currentBody = newBody;
    });
  }

  Widget _buildImageWithStyle(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(50, 50),
      backgroundColor: const Color.fromRGBO(250, 250, 255, 1.0),
      shape: const CircleBorder(),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(19, 49, 92, 1.0),
        toolbarHeight: 310,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1,
            width: 1,
            color: Colors.grey, 
          ),
        ),
        flexibleSpace: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CarouselSlider(
                items: [
                  _buildImageWithStyle(
                    'https://cdn.discordapp.com/attachments/1215338957923942431/1236622795002220664/logo.png?ex=6639ffb9&is=6638ae39&hm=140b50c521726d9105cefb807cbd40b8e6cc1f35f1f8b16424d67b6350fea551&',
                  ),
                  _buildImageWithStyle(
                    'https://cdn.discordapp.com/attachments/1215338957923942431/1236346595243462797/logo.png?ex=6639a73e&is=663855be&hm=55500d7d689c13766fb0d1e70af1bdadb81946c58c0d2f674a017643034705ba&',
                  ),
                ],
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          _setBody(homePage());
                        },
                        child: const Icon(
                          Icons.home,
                          size: 25,
                          color: Color.fromRGBO(19, 49, 92, 1.0),
                        ),
                      ),
                      const Text('Home', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          _setBody(mousePage());
                        },
                        child: const Icon(
                          Icons.mouse,
                          size: 25,
                          color: Color.fromRGBO(19, 49, 92, 1.0),
                        ),
                      ),
                      const Text('Mouse',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          _setBody(keyboardPage());
                        },
                        child: const Icon(
                          Icons.keyboard,
                          size: 25,
                          color: Color.fromRGBO(19, 49, 92, 1.0),
                        ),
                      ),
                      const Text('Keyboard',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          _setBody(headphonePage());
                        },
                        child: const Icon(
                          Icons.headset,
                          size: 25,
                          color: Color.fromRGBO(19, 49, 92, 1.0),
                        ),
                      ),
                      const Text('Headphone',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _currentBody,
    );
  }
}
