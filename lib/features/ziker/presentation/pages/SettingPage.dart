import 'package:azkar/features/ziker/presentation/widgets/SettingPageWidget/SettingWidget.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset : false,
          appBar: _buildAppbar(context),
          body: _buildBody(),
        ));
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text("الإعدادات"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "تم",
            style: TextStyle(
                color: Colors.white, fontSize: 18), // Set font size here
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return const SettingWidget();
  }
}
