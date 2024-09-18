import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/FontSize.dart';
import '../../../../core/Utils.dart';
import '../../../../core/colors.dart';
import '../bloc/azkar/setting/SettingBloc.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  double _textSize = 18;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildAppbar(context),
          body: _buildBody(),
        ));
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () async {
          Navigator.pop(context);
        },
      ),
      title: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is LoadedSettingState) {
            _textSize = Utils().fontSize(state.setting.fontSize);
            return Text(
              'عن البرنامج',
              style: TextStyle(fontSize: _textSize),
            );
          }

          return const Text('عن البرنامج');
        },
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: AppColors.c2Read,
      padding: EdgeInsets.only(left: 6.0, right: 6, top: 16, bottom: 16),
      // Add padding to avoid edges
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align content to the start
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Align text to the start
                    children: [
                      Text(
                        "الحمد لله رب العالمين والصلاة والسلام على رسول الله صلى الله عليه وسلم وبعد: \n" +
                            "فهذا تطبيق صحيح الأذكار وهو مأخوذ من مؤلفات",
                        style: TextStyle(
                            color: AppColors.c4Actionbar,
                            fontSize: _textSize),
                      ),
                      SizedBox(height: 10), // Space between text
                      Text('الشيخ الدكتور / ابو وسام وليد الرفاعي',
                        style: TextStyle(
                            fontFamily: 'alfont_com_alfont_com_4_30',
                            color: AppColors.c4Actionbar,
                            fontSize: _textSize),),
                      SizedBox(height: 10), // Space between text
                      Text(
                        "كما نرحب بالاقتراحات والملاحظات عبر نموذج التواصل بالموقع.\n" +
                            "ندعو الله عز وجل أن يتقبل منا هذا العمل وينفعنا وإياكم به. رجاءا لا تنسونا من صالح دعائكم وساهموا معنا في نشر تطبيق صحيح الأذكار والأدعية النبوية."
                        , style: TextStyle(
                          color: AppColors.c4Actionbar,
                          fontSize: _textSize),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // Space between text and image
          Align(
            alignment: Alignment.center, // Center image horizontally
            child: Image.network(
              'https://via.placeholder.com/150',
              // Replace with your image URL or asset path
              width: 150, // Set image width
              height: 150, // Set image height
            ),
          ),
        ],
      ),
    );
  }
}
