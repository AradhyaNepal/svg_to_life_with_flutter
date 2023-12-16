import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentCompleted extends StatelessWidget {
  const PaymentCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Container(
              height: 416.h,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SvgPicture.asset(

                    ),
                  ),
                  Positioned.fill(
                    child: child,
                  ),
                  Positioned.fill(
                    child: child,
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
