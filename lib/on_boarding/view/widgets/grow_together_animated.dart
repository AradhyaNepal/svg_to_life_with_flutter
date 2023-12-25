import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svg_to_life/constants/image_constants.dart';
import 'package:svg_to_life/on_boarding/view/model/on_boarding_model.dart';

class GrowTogetherAnimated extends StatefulWidget {
  const GrowTogetherAnimated({super.key});

  static OnBoardingModel get model => OnBoardingModel(
    widget: const GrowTogetherAnimated(),
    subTitle: "Mauris pretium ligula dolor. Morbi vehicula finibus felis, venenatis finibus urna volutpat a. Cras condimentum tellus vitae neque feugiat, sit amet luctus libero maximus.",
    title: "Grow Together",
  );

  @override
  State<GrowTogetherAnimated> createState() => _GrowTogetherAnimatedState();
}

class _GrowTogetherAnimatedState extends State<GrowTogetherAnimated>
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
    return AnimatedBuilder(
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
    );
  }
}
