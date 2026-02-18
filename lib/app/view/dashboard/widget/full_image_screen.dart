import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_feed/app/utils/colours.dart';
import 'package:image_feed/app/utils/utils.dart';

class FullScreenImage extends StatelessWidget {
  final String imageBase64;
  final String tag;

  const FullScreenImage({
    super.key,
    required this.imageBase64,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: pageBackgroundColor,
        elevation: 0,
        title: Text(
          "Image View",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),

      body: Center(
        child: Container(
          height: size.height * 0.7,
          width: size.width * 0.95,
          decoration: BoxDecoration(
            color: pageBackgroundColor,
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: defaultBorderRadius / 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            child: Hero(
              tag: tag,
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                child: Image.memory(
                  base64Decode(imageBase64),
                  fit: BoxFit.contain,
                  width: size.width,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
