import 'package:flutter/material.dart';

class ImageConstants{
   static const String assetsDir = "lib/src/assets";
  static String background(BuildContext context) => const ThemedImages(
        light: "$assetsDir/light_theme/bg_light.png",
       
      ).getImage(context);

  static String back(BuildContext context) => const ThemedImages(
        light: "$assetsDir/light_theme/back.svg",
       
      ).getImage(context);

  static String close(BuildContext context) => const ThemedImages(
        light: "$assetsDir/light_theme/close.svg",
       
      ).getImage(context);
}
class ThemedImages {
  final String light;


  const ThemedImages({
    required this.light,
    
  });

   String getImage(BuildContext context) {
    
      return light;
    
   
  }
}