import 'package:flutter/material.dart';

class IllustrationWidget extends StatelessWidget {
  final String imagePath;
  final double height;
  const IllustrationWidget({
    super.key,
    required this.imagePath,
    this.height = 230,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
