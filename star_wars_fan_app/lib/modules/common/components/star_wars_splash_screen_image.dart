import 'package:flutter/material.dart';

class StarWarsSplashScreenImage extends StatelessWidget {
  const StarWarsSplashScreenImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.network(
        'https://static.wikia.nocookie.net/starwars/images/c/cc/Star-wars-logo-new-tall.jpg/revision/latest?cb=20190313021755',
        scale: 0.8,
        fit: BoxFit.fill,
      ),
    );
  }
}
