import 'package:azkar/features/ziker/presentation/widgets/titlePageWidget/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/colors.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/AzkarTitlesBloc.dart';

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
        drawer: DrawerWidget()
        body: _buildBody(),
    );
  }
  Widget _buildBody(){
    return GestureDetector( onTap: () {
      Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<AzkarTitlesBloc, AzkarTitlesState>(
          builder: (context, state) {
            if (state is LoadingAzkarTitlesState) {
              // return LoadingWidget();
            } else if (state is LoadedAzkarTitlesState) {
              // return RefreshIndicator(
              //     onRefresh: () => _onRefresh(context),
              //     child: Container()//PostListWidget(posts: state.posts)
              // );
            } else if (state is ErrorAzkarTitlesState) {
              // return MessageDisplayWidget(message: state.message);
            }
            return const LoadingWidget();
          },
        ),
      );
    });
  }
}
