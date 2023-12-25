import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_to_life/constants/color_constants.dart';
import 'package:svg_to_life/on_boarding/view/on_boarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 958),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          title: 'SVG To Life',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor:  ColorConstants.primaryColor,primary: ColorConstants.primaryColor,),
            useMaterial3: true,
          ),
          home: const OnBoardingScreen(),
        );
      },
    );

  }
}
