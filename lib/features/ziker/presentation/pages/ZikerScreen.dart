
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/FontSize.dart';
import '../../../../core/utils/Utils.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/Ziker.dart';
import '../bloc/azkar/azkar/AzkarTitlesBloc.dart';
import '../bloc/azkar/setting/SettingBloc.dart';
import '../widgets/ZikerPageWidget/ZikerPageWidget.dart';
import '../widgets/titlePageWidget/message_display_widget.dart';

class ZikerPage extends StatelessWidget {
  final String zikerTitle;

  ZikerPage({required this.zikerTitle});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: _appBar(context),
          body: _buildBody(),
        ));
  }

  AppBar _appBar(BuildContext context) => AppBar(
      title: BlocBuilder<AzkarBloc, AzkarState>(
        builder: (context, state) {
          if (state is LoadedAzkarState) {
            return BlocBuilder<SettingBloc, SettingState>(
              builder: (context, state) {
                if (state is LoadedSettingState) {
                  return Text(
                    'صحيح الأذكار',
                    style: TextStyle(
                        fontSize: Utils().fontSize(state.setting.fontSize)),
                  );
                }

                return Text(
                  'صحيح الأذكار',
                  style: TextStyle(fontSize: Utils().fontSize(FontSize.Median)),
                );
              },
            );
          } else if (state is ErrorAzkarState) {}
          return const Text('صحيح الأذكار');
        },
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: BlocBuilder<AzkarBloc, AzkarState>(
        builder: (context, state) {
          if (state is LoadingAzkarState) {
            return LoadingWidget();
          } else if (state is LoadedAzkarState) {
            Ziker ziker =
                state.azkar.singleWhere((ziker) => ziker.name == zikerTitle);
            return Container(child: ZikerPageWidget(azkar: ziker));
          } else if (state is ErrorAzkarState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
