import 'package:azkar/core/colors.dart';
import 'package:azkar/features/ziker/presentation/pages/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPopupWidget extends StatelessWidget {

  final Function() onBack;

  const CustomPopupWidget(this.onBack, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: _DialogContent(context),
    );
  }

  Widget _DialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color of the dialog to white
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Image in the center
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/ic_baseline_check_circle_24.svg',
                height: 72,
                color: AppColors.c4Actionbar,
              ),
            ],
          ),
          const SizedBox(height: 20), // Space between image and first text

          // Text below the image
          const Text(
            "انتهى الذكر",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10), // Space between texts

          // Text with background color and rounded corners (1st)
          GestureDetector(
            onTap: onBack,
            child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.c4Actionbar, // Background color
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: const Text(
              "العودة الى القائمة الرئيسية",
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )),
          const SizedBox(height: 10), // Space between texts

          // Text with another background color and rounded corners (2nd)
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cCancelBG, // Another background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: const Text(
                "الغاء",
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),)
        ],
      ),
    );
  }
}
