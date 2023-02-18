

import 'package:flutter/cupertino.dart';

class LayoutConstants{


  static double?  title_fontsize(BuildContext context){

    Size device_size = MediaQuery.of(context).size;
    double? width = device_size.width;

    if (width <= 480){
      return 30.0;
    }
    else if (width > 480 && width < 800){
      return 40.0;
    }
    else if (width > 800 && width < 1440){
      return 50.0;
    }
    else if (width > 1440){
      return 75.0;
    }

    return 50.0;
  }


  static double?  subtitle_fontsize(BuildContext context){

    Size device_size = MediaQuery.of(context).size;
    double? width = device_size.width;

    if (width <= 480){
      return 12.0;
    }
    else if (width > 480 && width < 800){
      return 14.0;
    }
    else if (width > 800 && width < 1440){
      return 16.0;
    }
    else if (width > 1440){
      return 18.0;
    }

    return 16.0;
  }


  static double?  subtitle2_fontsize(BuildContext context){

    Size device_size = MediaQuery.of(context).size;
    double? width = device_size.width;

    if (width <= 480){
      return 20.0;
    }
    else if (width > 480 && width < 800){
      return 25.0;
    }
    else if (width > 800 && width < 1440){
      return 35.0;
    }
    else if (width > 1440){
      return 40.0;
    }

    return 35.0;
  }

  static double?  logo_size(BuildContext context){

    Size device_size = MediaQuery.of(context).size;
    double? width = device_size.width;

    if (width <= 480){
      return 40.0;
    }
    else if (width > 480 && width < 800){
      return 60.0;
    }
    else if (width > 800 && width < 1440){
      return 80.0;
    }
    else if (width > 1440){
      return 100.0;
    }

    return 80.0;
  }


  static Size?  button_size(BuildContext context){

    Size device_size = MediaQuery.of(context).size;
    double? width = device_size.width;

    if (width <= 480){
      return Size(150, 35);
    }
    else if (width > 480 && width < 800){
      return Size(200, 45);
    }
    else if (width > 800 && width < 1440){
      return Size(250, 55);
    }
    else if (width > 1440){
      return Size(300, 55);
    }

    return Size(250, 55);
  }


  static double?  circle_size(BuildContext context){

    Size device_size = MediaQuery.of(context).size;
    double? width = device_size.width;

    if (width <= 480){
      return 30.0;
    }
    else if (width > 480 && width < 800){
      return 40.0;
    }
    else if (width > 800 && width < 1440){
      return 40.0;
    }
    else if (width > 1440){
      return 50.0;
    }

    return 40.0;
  }

  static double?  circle_thickness_size(BuildContext context){

    Size device_size = MediaQuery.of(context).size;
    double? width = device_size.width;

    if (width <= 480){
      return 3.0;
    }
    else if (width > 480 && width < 800){
      return 3.0;
    }
    else if (width > 800 && width < 1440){
      return 4.0;
    }
    else if (width > 1440){
      return 4.0;
    }

    return 4.0;
  }


  static double?  circle_vertical_padding(BuildContext context){

    Size device_size = MediaQuery.of(context).size;
    double? width = device_size.width;

    if (width <= 480){
      return 5;
    }
    else if (width > 480 && width < 800){
      return 10;
    }
    else if (width > 800 && width < 1440){
      return 15;
    }
    else if (width > 1440){
      return 20;
    }

    return 15.0;
  }


  static double?  circle_horizontal_padding(BuildContext context){

    Size device_size = MediaQuery.of(context).size;
    double? width = device_size.width;

    if (width <= 480){
      return 2;
    }
    else if (width > 480 && width < 800){
      return 3;
    }
    else if (width > 800 && width < 1440){
      return 4;
    }
    else if (width > 1440){
      return 5;
    }

    return 4.0;
  }

}