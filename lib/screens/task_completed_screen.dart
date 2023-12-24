import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svg_to_life/constants/image_constants.dart';

class TaskCompletedScreen extends StatefulWidget {
  const TaskCompletedScreen({super.key});

  @override
  State<TaskCompletedScreen> createState() => _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController
      _controller; // Value start from 0 and ends at 1
  late final Animation<double> _personOpacityAnimation;
  late final Animation<double> _itemsScaleAnimation;
  late final Animation<Offset> _star1TransformAnimation;
  late final Animation<double> _star1OpacityAnimation;
  late final Animation<Offset> _star2TransformAnimation;
  late final Animation<double> _star2OpacityAnimation;
  late final Animation<Offset> _star3TransformAnimation;
  late final Animation<double> _star3OpacityAnimation;
  late final Animation<double> _headerOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 4000,
      ),
    );
    //Interval: 0 to 1. eg: 0.25 -> 25% of 5 seconds
    _personOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          0.35,
          curve: Curves.decelerate, //Just experiment with these curves
        ),
      ),
    );
    _itemsScaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.2,
          0.35,
        ),
      ),
    );
    _headerOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.2,
          0.5,
          curve: Curves.easeIn, //Just experiment with these curves
        ),
      ),
    );
    _star1OpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.5,
          0.585,
        ),
      ),
    );
    _star1TransformAnimation =
        Tween<Offset>(begin: Offset(0, 35.h), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.5,
          0.67,
        ),
      ),
    );
    _star2OpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.67,
          0.755,
        ),
      ),
    );
    _star2TransformAnimation =
        Tween<Offset>(begin: Offset(0, 35.h), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.67,
          0.84,
        ),
      ),
    );
    _star3OpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.84,
          0.925,
        ),
      ),
    );
    _star3TransformAnimation =
        Tween<Offset>(begin: Offset(0, 35.h), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.84,
          1,
        ),
      ),
    );

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
                      child ?? const SizedBox(),
                      Positioned.fill(
                        child: Transform.scale(
                          scale: _personOpacityAnimation.value,
                          child: SvgPicture.asset(
                            ImageConstants.taskCompletedItems,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Opacity(
                          opacity: _personOpacityAnimation.value,
                          child: SvgPicture.asset(
                            ImageConstants.taskCompletedPerson,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Opacity(
                          opacity: _headerOpacityAnimation.value,
                          child: SvgPicture.asset(
                            ImageConstants.taskCompletedHeader,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Transform.translate(
                          offset: _star1TransformAnimation.value,
                          child: Opacity(
                            opacity: _star1OpacityAnimation.value,
                            child: SvgPicture.asset(
                              ImageConstants.taskCompletedStar1,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Transform.translate(
                          offset: _star2TransformAnimation.value,
                          child: Opacity(
                            opacity: _star2OpacityAnimation.value,
                            child: SvgPicture.asset(
                              ImageConstants.taskCompletedStar2,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Transform.translate(
                          offset: _star3TransformAnimation.value,
                          child: Opacity(
                            opacity: _star3OpacityAnimation.value,
                            child: SvgPicture.asset(
                              ImageConstants.taskCompletedStar3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                child: Positioned.fill(
                  child: SvgPicture.asset(
                    ImageConstants.taskCompletedBackground,
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
