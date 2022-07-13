
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Size {

  double width;
  double height;
  Size({
    required this.width,
    required this.height,
  });


}


class Default{

  //
  //TODO: enter user key for using rapidapi apis
  //
  //

  static String rapidapiKey = "";

  static Color default_orange = const Color.fromARGB(255, 253, 182, 73);
  static Color default_red = const Color.fromARGB(255, 204, 46, 56);
  static String errorImagePath = "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png";

  
  static Size scaleWithScreen(BuildContext context, double centage){
    var sizeOfScreen = MediaQuery.of(context); 

    final double width = sizeOfScreen.size.width;
    final double height = sizeOfScreen.size.height;

    var resultWidth = (centage/100) * width;
    var resultHeight = (centage/100) * height;

    return Size(width: resultWidth, height: resultHeight);
  }

  TextStyle font(TextStyle style){

    return GoogleFonts.lato(textStyle: style);

  }

  static int getRandomNumber(int min, int max){

    return (min + Random().nextInt(max - min));

  }

  static List<int> getRandomNumbersWithCount(int min,int max,int count){

    List<int> result = [];
    for(int i=0; i< count; i++){
      result.add(getRandomNumber(min, max));
    }

    return result;
  }



}




