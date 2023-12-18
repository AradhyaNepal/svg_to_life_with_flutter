import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svg_to_life/constants/image_constants.dart';
import 'package:svg_to_life/constants/radius_to_radian.dart';

class PaymentCompleted extends StatefulWidget {
  const PaymentCompleted({super.key});

  @override
  State<PaymentCompleted> createState() => _PaymentCompletedState();
}

class _PaymentCompletedState extends State<PaymentCompleted>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _girlWalkAnimation;
  late final Animation<double> _itemsRotateAnimation;
  late final Animation<double> _itemsScaleAnimation;
  late final Animation<double> _mobileTopFallFromTopAnimation;
  late final Animation<double> _mobileMidComeFromRightAnimation;
  late final Animation<double> _mobileBottomOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    _girlWalkAnimation = Tween<double>(end: 0, begin: -100.w).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          0.33,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _mobileTopFallFromTopAnimation = Tween<double>(begin: 40.h, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.33,
          0.55,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _mobileMidComeFromRightAnimation =
        Tween<double>(begin: 50.w, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.55,
          0.77,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _mobileBottomOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.77,
          0.1,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _itemsRotateAnimation =
        Tween<double>(end: 0, begin: degreeToRadian(-30)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );

    final smallSizeTween = Tween<double>(
      begin: 1,
      end: 0.75,
    );
    final bigSizeTween = Tween<double>(
      begin: 0.75,
      end: 1,
    );
    _itemsScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: smallSizeTween,
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: bigSizeTween,
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: smallSizeTween,
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: bigSizeTween,
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: smallSizeTween,
        weight: 0.2,
      ),
    ]).animate(
      _controller,
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
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          return Transform.rotate(
                            angle: _itemsRotateAnimation.value,
                            child: Transform.scale(
                              scale: _itemsScaleAnimation.value,
                              child: SvgPicture.asset(
                                ImageConstants.examCompleteItems,
                              ),
                            ),
                          );
                        }),
                  ),
                  Positioned.fill(
                    child: SvgPicture.asset(
                      ImageConstants.examCompleteBackground,
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedBuilder(
                        animation: _girlWalkAnimation,
                        builder: (context, _) {
                          return Transform.translate(
                            offset: Offset(_girlWalkAnimation.value, 0),
                            child: SvgPicture.asset(
                              ImageConstants.examCompletePerson,
                            ),
                          );
                        }),
                  ),
                  Positioned.fill(
                    child: AnimatedBuilder(
                        animation: _mobileTopFallFromTopAnimation,
                        builder: (context, _) {
                          return Transform.translate(
                            offset:
                                Offset(0, _mobileTopFallFromTopAnimation.value),
                            child: SvgPicture.asset(
                              ImageConstants.examCompleteMobileTop,
                            ),
                          );
                        }),
                  ),
                  Positioned.fill(
                    child: AnimatedBuilder(
                        animation: _mobileMidComeFromRightAnimation,
                        builder: (context, _) {
                          return Transform.translate(
                            offset: Offset(
                                _mobileMidComeFromRightAnimation.value, 0),
                            child: SvgPicture.asset(
                              ImageConstants.examCompleteMobileMiddle,
                            ),
                          );
                        }),
                  ),
                  Positioned.fill(
                    child: AnimatedBuilder(
                        animation: _mobileBottomOpacityAnimation,
                        builder: (context, _) {
                          return Opacity(
                            opacity: _mobileBottomOpacityAnimation.value,
                            child: SvgPicture.asset(
                              ImageConstants.examCompleteMobileBottom,
                            ),
                          );
                        }),
                  ),
                ],
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
