import 'package:azkar/features/ziker/presentation/widgets/titlePageWidget/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/colors.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/AzkarTitlesBloc.dart';
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
      title: Text('صحيح الأذكار'),
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
          // return Container(
          //     child: Text("state $state",
          //         textAlign: TextAlign.center,
          //         style: TextStyle(fontSize: 40, color: AppColors.c1Drawer)));
          if (state is LoadingAzkarTitlesState) {
            print("sate: 1");
            return LoadingWidget();
          } else if (state is LoadedAzkarTitlesState) {
            print("sate: 2");
            return Container(child: AzkarListWidget(azkar: state.azkar));
          } else if (state is ErrorAzkarTitlesState) {
            print("sate: 3");
            return MessageDisplayWidget(message: state.message);
          }
          print("sate: 4");
          return const LoadingWidget();
        },
      ),
    );
  }
}
