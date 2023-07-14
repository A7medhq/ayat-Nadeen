import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quran_api/services/quran_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoaded = false;

  final ImageProvider _assetsImage =
      const AssetImage('assets/images/mosque.jpg');
  final ImageProvider _networkImage = const NetworkImage(
      'https://source.unsplash.com/random/?quran,mosque,prayer,nature,rivers,islamic/?orientation=portrait');

  String? ayah;
  QuranModel quranModel = QuranModel();

  void getImage() {
    _networkImage
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      setState(() {
        isLoaded = true;
      });
    }));
  }

  @override
  void initState() {
    getImage();
    getAyah();
    super.initState();
  }

  getAyah() {
    quranModel.getRandomAyah().then((value) {
      ayah = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: !isLoaded ? _assetsImage : _networkImage,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.1),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                // color: Colors.white.withOpacity(0.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ayah != null
                        ? Text(
                            '$ayah',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'بسم الله الرحمن الرحيم',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
