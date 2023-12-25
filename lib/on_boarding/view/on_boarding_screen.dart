import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:svg_to_life/constants/color_constants.dart';
import 'package:svg_to_life/on_boarding/view/widgets/complete_task_animated.dart';
import 'package:svg_to_life/on_boarding/view/widgets/explore_gifts_animated.dart';
import 'package:svg_to_life/on_boarding/view/widgets/grow_together_animated.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  final _onBoardingItems = [
    CompleteTaskAnimated.model,
    GrowTogetherAnimated.model,
    ExploreGiftsAnimated.model,
  ];
  late final AnimationController _controller;
  late final Animation<double> _subTitleDxAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _subTitleDxAnimation =
        Tween<double>(begin: -400.w, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = _onBoardingItems[_index];
    return WillPopScope(
      onWillPop: () async {
        if (_isFirst) return true;
        _index--;
        _changeScreen();
        return false;
      },
      child: GestureDetector(
        onHorizontalDragEnd: (drag) {
          final dragVelocity = drag.primaryVelocity ?? 0;
          if (dragVelocity > 100) {
            _onDragGoPrevious();
          } else if (dragVelocity < 100) {
            _onDragGoNext();
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: currentItem.widget,
                ),
                Transform.translate(
                  //Its might be bad practice to do so, but just for practice project I am doing so.
                  offset: Offset(0, -30.h),
                  child: AnimatedSmoothIndicator(
                    activeIndex: _index,
                    count: _totalLength,
                    effect: ExpandingDotsEffect(
                      activeDotColor: ColorConstants.primaryColor,
                      dotColor: Colors.grey.shade400,
                      dotHeight: 8.0,
                      dotWidth: 8.0,
                      spacing: 8.w,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23.w),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Opacity(
                            opacity: _controller.value,
                            child: Text(
                              currentItem.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Transform.translate(
                            offset: Offset(_subTitleDxAnimation.value, 0),
                            child: Text(
                              currentItem.subTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          child ?? const SizedBox(),
                        ],
                      );
                    },
                    child: Theme(
                      data: Theme.of(context).copyWith(useMaterial3: false),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isLast) {
                            return; //In real scenario it must redirect user to screens like login
                          }

                          _index++;
                          _changeScreen();
                        },
                        child: Text(
                          _isLast ? "Get Started" : "Next",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 125.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDragGoNext() {
    if (_isLast) return;
    _index++;
    _changeScreen();
  }

  void _onDragGoPrevious() {
    if (_isFirst) return;
    _index--;
    _changeScreen();
  }

  void _changeScreen() {
    _controller.forward(from: 0);
    setState(() {});
  }

  bool get _isFirst => _index == 0;

  bool get _isLast => _index == _totalLength - 1;

  int get _totalLength => _onBoardingItems.length;
}
