import 'dart:ffi';

import 'package:azkar/core/utils/FontSize.dart';
import 'package:azkar/core/utils/Status.dart';
import 'package:azkar/core/utils/notification_helper.dart';
import 'package:azkar/features/ziker/domain/entities/PrayerTime.dart';
import 'package:azkar/features/ziker/domain/usecases/GetPrayerTimesUsecase.dart';
import 'package:azkar/features/ziker/presentation/bloc/azkar/setting/SettingBloc.dart';
import 'package:azkar/features/ziker/presentation/widgets/titlePageWidget/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/utils/Utils.dart';
import '../../../../core/colors.dart';
import '../../../../core/utils/location_helper.dart';
import '../../../../core/utils/notification_daily_test.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/Setting.dart';
import '../../domain/usecases/SetNewSettingUsecase.dart';
import '../bloc/PrayerTime/PrayerTimeCubit.dart';
import '../bloc/azkar/azkar/AzkarTitlesBloc.dart';
import '../widgets/titlePageWidget/TitlesListPageWidget.dart';
import '../widgets/titlePageWidget/message_display_widget.dart';
import 'ZikerScreen.dart';

class MainPage extends StatefulWidget {
  final String? title;

  MainPage({super.key, this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState(title);
}

class _MyHomePageState extends State<MainPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final String? title;

  _MyHomePageState(this.title);

  @override
  void initState() {
    NotificationHelper.requestPermissions();
    NotificationHelper.firstTimeOnly(context);
    _handleOnClickNotificationEvent(title);
    super.initState();
  }

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
          icon: Icon(Icons.dehaze),
          onPressed: () {
            // checkPendingNotificationRequests(
            //     context, NotificationHelper.getNotificationInstance());
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
      child: BlocBuilder<AzkarBloc, AzkarState>(
        builder: (context, state) {
          if (state is LoadingAzkarState) {
            return LoadingWidget();
          } else if (state is LoadedAzkarState) {
            return Container(child: AzkarListWidget(azkar: state.azkar));
          } else if (state is ErrorAzkarState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  void _handleOnClickNotificationEvent(String? title) {
    if (title == null) return;
    if (title == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZikerPage(zikerTitle: title),
        ),
      );
    }
  }
}
