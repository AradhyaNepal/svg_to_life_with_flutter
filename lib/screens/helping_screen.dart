import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svg_to_life/constants/image_constants.dart';

class HelpingScreen extends StatefulWidget {
  const HelpingScreen({super.key});

  @override
  State<HelpingScreen> createState() => _HelpingScreenState();
}

class _HelpingScreenState extends State<HelpingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _upperCloudDxAnimation;
  late final Animation<double> _bottomCloudDxAnimation;
  late final Animation<double> _personDxAnimation;
  late final Animation<double> _personDyAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    final itemCurveController=CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0,
        1,
        curve: Curves.decelerate,
      ),
    );
    _upperCloudDxAnimation =
        Tween<double>(begin: -250.w, end: 0).animate(itemCurveController);
    _bottomCloudDxAnimation =
        Tween<double>(begin: 250.w, end: 0).animate(itemCurveController);
    final personCurveController=CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0,
        0.75,
        curve: Curves.easeInOut,
      ),
    );
    _personDxAnimation = Tween<double>(begin: -100.w, end: 0).animate(
      personCurveController,
    );
    _personDyAnimation =
        Tween<double>(begin: 100.h, end: 0).animate(personCurveController);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 80.h),
            SizedBox(
              height: 416.h,
              width: double.infinity,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Transform.translate(
                          offset: Offset(_upperCloudDxAnimation.value, 0),
                          child: SvgPicture.asset(
                            ImageConstants.helpingUpperClouds,
                          ),
                        ),
                      ),
                      child ?? const SizedBox(),
                      Positioned.fill(
                        child: Transform.translate(
                          offset: Offset(_personDxAnimation.value,
                              _personDyAnimation.value),
                          child: SvgPicture.asset(
                            ImageConstants.helpingGoingUp,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Transform.translate(
                          offset: Offset(_bottomCloudDxAnimation.value, 0),
                          child: SvgPicture.asset(
                            ImageConstants.helpingBottomClouds,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                child: Positioned.fill(
                  child: SvgPicture.asset(
                    ImageConstants.helpingBackground,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 46.h,
            ),
            SizedBox(
              height: 46.h,
            ),
            SizedBox(
              height: 46.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE8505B),
              ),
              onPressed: () {
                _controller.reset();
                _controller.forward();
              },
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
