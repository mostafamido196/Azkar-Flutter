import 'package:azkar/core/utils/notification_helper.dart';
import 'package:azkar/features/ziker/presentation/bloc/azkar/azkar/AzkarTitlesBloc.dart';
import 'package:azkar/features/ziker/presentation/bloc/azkar/setting/SettingBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_theme.dart';
import 'core/colors.dart';
import 'features/ziker/presentation/pages/MainScreen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHelper.init();
  await di.init();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<AzkarBloc>()..add(GetAllAzkarTitlesEvent())),
          BlocProvider(
              create: (_) => di.sl<SettingBloc>()..add(GetOldSettingEvent())),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            title: 'صحيح الأذكار',
            home: const MainPage()));
  }
}
