import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svg_to_life/constants/image_constants.dart';
import 'package:svg_to_life/constants/radius_to_radian.dart';
import 'package:svg_to_life/on_boarding/view/model/on_boarding_model.dart';

class CompleteTaskAnimated extends StatefulWidget {
  const CompleteTaskAnimated({super.key});

  static OnBoardingModel get model => OnBoardingModel(
        widget: const CompleteTaskAnimated(),
        subTitle: "Mauris pretium ligula dolor. Morbi vehicula finibus felis, venenatis finibus urna volutpat a. Cras condimentum tellus vitae neque feugiat, sit amet luctus libero maximus.",
        title: "Complete the Task",
      );

  @override
  State<CompleteTaskAnimated> createState() => _CompleteTaskAnimatedState();
}

class _CompleteTaskAnimatedState extends State<CompleteTaskAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController
      _controller; // Value start from 0 and ends at 1
  late final Animation<double> _personOpacityAnimation;
  late final Animation<double> _personRotateAnimation;
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
        milliseconds: 3000,
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
    _personRotateAnimation =
        Tween<double>(begin: degreeToRadian(-45), end: degreeToRadian(0))
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
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
    return AnimatedBuilder(
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
              child: Transform.rotate(
                angle: _personRotateAnimation.value,
                child: Opacity(
                  opacity: _personOpacityAnimation.value,
                  child: SvgPicture.asset(
                    ImageConstants.taskCompletedPerson,
                  ),
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
    );
  }
}
