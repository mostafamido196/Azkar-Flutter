import 'dart:ffi';

import 'package:azkar/features/ziker/presentation/bloc/azkar/setting/SettingBloc.dart';
import 'package:azkar/features/ziker/presentation/widgets/titlePageWidget/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/Utils.dart';
import '../../../../core/colors.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/Setting.dart';
import '../bloc/azkar/azkar/AzkarTitlesBloc.dart';
import '../widgets/titlePageWidget/TitlesListPageWidget.dart';
import '../widgets/titlePageWidget/message_display_widget.dart';

class AzkarTitlePage extends StatefulWidget {
  const AzkarTitlePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AzkarTitlePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: _appBar(),
          body: _drawerAndBody(),
        ));
  }

  AppBar _appBar() => AppBar(
      title: BlocBuilder<AzkarTitlesBloc, AzkarTitlesState>(
        builder: (context, state) {
          // print('mos state:${state}');
          if (state is LoadedAzkarTitlesState) {
            // print('mos LoadedAzkarTitlesState');
            return Text(
              'صحيح الأذكار',
              style: TextStyle(fontSize: Utils().fontSize(state.azkar.first.font)),
            );
          } else if (state is ErrorAzkarTitlesState) {
            // print('mos ErrorAzkarTitlesState e:${state.message}');
          }
          // print('mos else');
          return const Text('صحيح الأذكار');
        },
      ),
      leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () {
            if (_scaffoldKey.currentState!.isDrawerOpen == false) {
              _scaffoldKey.currentState!.openDrawer();
            } else {
              _scaffoldKey.currentState!.openEndDrawer();
            }
          }));

  Widget _drawerAndBody() {
    return Scaffold(
        key: _scaffoldKey,
        body: _buildBody(),
        drawer: const Opacity(
          opacity: 0.7,
          child: DrawerWidget(),
        ));
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<AzkarTitlesBloc, AzkarTitlesState>(
        builder: (context, state) {
          if (state is LoadingAzkarTitlesState) {
            return LoadingWidget();
          } else if (state is LoadedAzkarTitlesState) {
            return Container(child: AzkarListWidget(azkar: state.azkar));
          } else if (state is ErrorAzkarTitlesState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
