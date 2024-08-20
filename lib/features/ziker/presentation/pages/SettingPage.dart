import 'package:azkar/core/FontSize.dart';
import 'package:azkar/core/error/exceptions.dart';
import 'package:azkar/features/ziker/presentation/bloc/azkar/setting/SettingBloc.dart';
import 'package:azkar/features/ziker/presentation/widgets/SettingPageWidget/SettingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Utils.dart';
import '../../domain/entities/Setting.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);

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
      title: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          // print('mos state:${state}');
          if (state is LoadingSettingState) {
            return const Text('الإعدادات');
          } else if (state is LoadingSettingState) {
            return const Text('الإعدادات');
          } else if (state is LoadedSettingState) {
            return Text(
              'الإعدادات',
              style:
                  TextStyle(fontSize: Utils().fontSize(state.setting.fontSize)),
            );
          } else if (state is ErrorSettingState) {
            return Text(
              'الإعدادات',
              style: TextStyle(fontSize: Utils().fontSize(FontSize.Median)),
            );
          }
          return const Text('الإعدادات');
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              print("seetingstate: $state");
              if (state is LoadingSettingState) {
                return const Text('تم');
              } else if (state is LoadedSettingState) {
                return Text(
                  'تم',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Utils().fontSize(state.setting.fontSize)),
                );
              } else if (state is ErrorSettingState) {
                return Text(
                  'تم',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Utils().fontSize(FontSize.Median)),
                );
              }
              return const Text('تم');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return const SettingWidget();
  }
}
