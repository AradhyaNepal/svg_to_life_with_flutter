import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svg_to_life/constants/image_constants.dart';
import 'package:svg_to_life/constants/radius_to_radian.dart';
import 'package:svg_to_life/on_boarding/view/model/on_boarding_model.dart';

class ExploreGiftsAnimated extends StatefulWidget {
  static OnBoardingModel get model => OnBoardingModel(
        widget: const ExploreGiftsAnimated(),
        subTitle:
            "Mauris pretium ligula dolor. Morbi vehicula finibus felis, venenatis finibus urna volutpat a. Cras condimentum tellus vitae neque feugiat, sit amet luctus libero maximus.",
        title: "Explore Gifts",
      );

  const ExploreGiftsAnimated({super.key});

  @override
  State<ExploreGiftsAnimated> createState() => _ExploreGiftsAnimatedState();
}

class _ExploreGiftsAnimatedState extends State<ExploreGiftsAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _girlWalkAnimation;
  late final Animation<double> _itemsRotateAnimation;
  late final Animation<double> _itemsScaleAnimation;
  late final Animation<double> _mobileTopFallFromTopAnimation;
  late final Animation<double> _mobileTopOpacityAnimation;
  late final Animation<double> _mobileMidOpacityAnimation;
  late final Animation<double> _mobileMidComeFromRightAnimation;
  late final Animation<double> _mobileBottomOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3500));
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

    _mobileTopFallFromTopAnimation =
        Tween<double>(begin: -40.h, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.33,
          0.55,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _mobileTopOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.33,
          0.44,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _mobileMidComeFromRightAnimation =
        Tween<double>(begin: -50.w, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.55,
          0.77,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _mobileMidOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.55,
          0.66,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _mobileBottomOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.77,
          1,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _itemsRotateAnimation =
        Tween<double>(end: 0, begin: degreeToRadian(90)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          0.5,
          curve: Curves.bounceOut,
        ),
      ),
    );

    final smallSizeTween = Tween<double>(
      begin: 1,
      end: 0.85,
    );
    final bigSizeTween = Tween<double>(
      begin: 0.85,
      end: 1,
    );
    _itemsScaleAnimation = TweenSequence<double>([
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
      TweenSequenceItem(
        tween: bigSizeTween,
        weight: 0.2,
      ),
    ]).animate(
        CurvedAnimation(
          parent:_controller ,
          curve: const Interval(
            0,
            0.5,
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
    return Stack(
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
              animation: Listenable.merge(
                  [_mobileTopFallFromTopAnimation, _mobileTopOpacityAnimation]),
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, _mobileTopFallFromTopAnimation.value),
                  child: Opacity(
                    opacity: _mobileTopOpacityAnimation.value,
                    child: SvgPicture.asset(
                      ImageConstants.examCompleteMobileTop,
                    ),
                  ),
                );
              }),
        ),
        Positioned.fill(
          child: AnimatedBuilder(
              animation: Listenable.merge([
                _mobileMidComeFromRightAnimation,
                _mobileMidOpacityAnimation
              ]),
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(_mobileMidComeFromRightAnimation.value, 0),
                  child: Opacity(
                    opacity: _mobileMidOpacityAnimation.value,
                    child: SvgPicture.asset(
                      ImageConstants.examCompleteMobileMiddle,
                    ),
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
    );
  }
}
