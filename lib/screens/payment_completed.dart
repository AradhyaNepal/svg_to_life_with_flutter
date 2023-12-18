import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svg_to_life/constants/image_constants.dart';

class PaymentCompleted extends StatelessWidget {
  const PaymentCompleted({super.key});

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
              child:
                SvgPicture.asset(ImageConstants.examComplete),
              // Stack(
              //   children: [
              //     Positioned.fill(
              //       child: SvgPicture.asset(
              //         ImageConstants.examCompleteBackground,
              //       ),
              //     ),
              //     Positioned.fill(
              //       child: SvgPicture.asset(
              //         ImageConstants.examCompleteMobile,
              //       ),
              //     ),
              //     Positioned.fill(
              //       child: SvgPicture.asset(
              //         ImageConstants.examCompletePerson,
              //       ),
              //     ),
              //   ],
              // ),
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
              onPressed: () {},
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
