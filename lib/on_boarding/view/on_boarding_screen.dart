import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_to_life/on_boarding/view/model/on_boarding_model.dart';
import 'package:svg_to_life/on_boarding/view/widgets/complete_task_animated.dart';
import 'package:svg_to_life/on_boarding/view/widgets/explore_gifts_animated.dart';
import 'package:svg_to_life/on_boarding/view/widgets/grow_together_animated.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;
  final _onBoardingItems = [
    CompleteTaskAnimated.model,
    ExploreGiftsAnimated.model,
    GrowTogetherAnimated.model,
  ];

  @override
  Widget build(BuildContext context) {
    final currentItem = _onBoardingItems[index];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 80.h,
            ),
            Expanded(
              child: currentItem.widget,
            ),
            SizedBox(
              height: 75.h,
            ),
            Text(currentItem.title),
            SizedBox(
              height: 5.h,
            ),
            Text(
              currentItem.subTitle,
            ),
            SizedBox(
              height: 125.h,
            ),
          ],
        ),
      ),
    );
  }
}
